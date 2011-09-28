package massive.mcover;

import massive.mcover.client.TraceClient;
import massive.mcover.CoverageClient;
import massive.mcover.CoverageEntry;
import massive.mcover.CoverageEntryCollection;

import massive.mcover.util.Timer;


class MCoverRunner
{
	static public var instance:MCoverRunner = new MCoverRunner(); 

	static var logQueue:Array<String> = [];
	static var clientQueue:Array<CoverageClient> = [];
	static var reportPending:Bool = false;
	
	/**
	* method called from injected code each time a code block executes
	**/
	@IgnoreCover
	static public function log(value:String)
	{	
		logQueue.push(value);
	}

	/**
	* Trigger runner to calculate coverage and pass results to registered clients.
	**/
	static public function report()
	{
		reportPending = true;
	}

	/**
	 * Add one or more coverage clients to interpret coverage results.
	 * 
	 * @param	client		a  client to interpret coverage results 
	 */
	static public function addClient(client:CoverageClient):Void
	{
		clientQueue.push(client);
	}

	/**
	 * Handler called when all clients 
	 * have completed processing the results.
	 */
	public var completionHandler:Float -> Void;

	public var total(default, null):Int;
	public var count(default, null):Int;

	var clients:Array<CoverageClient>;
	var entries:IntHash<CoverageEntry>;
	var classes:Hash<CoverageEntryCollection>;
	var packages:Hash<CoverageEntryCollection>;

	var clientCompleteCount:Int;
	var timer:Timer;

	/**
	 * Class constructor.
	 * 
	 * Initializes timer to handle incoming logs on a set interval.
	 * This is to prevent logs being parsed before instance is initialized
	 * (edge case but always occurs when running against MCover!!)
	 */
	public function new()
	{
		reset();
	}

	public function reset()
	{
		clients = [];

		entries = new IntHash();
		classes = new Hash();
		packages = new Hash();

		parseEntries();		
		
		total = Lambda.count(entries);
		count = 0;

		if(timer != null) timer.stop();
		timer = new Timer(10);
		timer.run = tick;	
	}

	@IgnoreCover
	function tick()
	{
		var localClients = clientQueue.concat([]);
		clientQueue = [];
		
		for(client in localClients)
		{
			client.completionHandler = clientCompletionHandler;
			clients.push(client);
		}

		var localLogs = logQueue.concat([]);
		logQueue = [];

		for(value in localLogs)
		{
			logEntry(value);
		}

		if(reportPending == true)
		{
			reportPending = false;
			reportResults();
			timer.stop();
			timer = null;
		}
	}
	
	/**
	 * Log an individual call from within the code base.
	 * Do not call directly. The method only called via code injection by the compiler
	 * 
	 * @param	value		a string representation of a CoverageEntry
	 * @see mcover.CoverageEntry
	 */
	function logEntry(value:String)
	{		
		//trace(value);
		var temp = new CoverageEntry(value);
		
		if(!entries.exists(temp.id)) throw "Unexpected entry " + value;
		
		var entry = entries.get(temp.id);

		if(!entry.result)
		{
			count += 1;
		}

		entry.count += 1;

		for (client in clients) client.logEntry(entry);
	}
	
	function reportResults()
	{
		clientCompleteCount = 0;

		if(clients.length == 0)
		{
			var client = new TraceClient();
			client.completionHandler = clientCompletionHandler;
			clients.push(client);
		}
			
		for (client in clients)
		{	
			client.report(total, count, entries, classes, packages);
		}
	}

	function clientCompletionHandler(client:CoverageClient):Void
	{
		if (++clientCompleteCount == clients.length)
		{
			if (completionHandler != null)
			{
				var percent:Float = count/total;
				var handler:Dynamic = completionHandler;
				Timer.delay(function() { handler(percent); }, 1);
			}
		}
	}

	function parseEntries()
	{
		var file = haxe.Resource.getString("MCover");

		if(file == null) return;
		var lines = file.split("\n");

		for(line in lines)
		{
			line = StringTools.trim(line);
			if(line.length == 0) continue;
			var entry = new CoverageEntry(line);
		
			addEntryToHashes(entry);
		}
	}

	function addEntryToHashes(entry:CoverageEntry)
	{
		entries.set(Lambda.count(entries), entry);

		var packageKey = entry.packageName != "" ?  entry.packageName : "[default]";
		if(!packages.exists(packageKey))
		{
			packages.set(packageKey, new CoverageEntryCollection(packageKey));
		}

		var pckg = packages.get(packageKey);
		pckg.addEntry(entry);


		var classKey = entry.packageName != "" ? entry.packageName + "." + entry.className : entry.className;
		if(!classes.exists(classKey))
		{
			classes.set(classKey, new CoverageEntryCollection(classKey));
		}

		var cls = classes.get(classKey);
		cls.addEntry(entry);
	}
}