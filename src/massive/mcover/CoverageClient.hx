package massive.mcover;

import massive.mcover.data.Statement;
import massive.mcover.data.Branch;
import massive.mcover.data.AllClasses;


interface CoverageClient
{
	/**
	 * Handler which if present, should be called when the client has completed its processing of the results.
	 */
	var completionHandler(default, default):CoverageClient -> Void;
		
	/**
	 * Called when a statement code block is executed at runtime.
	 *  
	 * @param	block		a code block  
	 */
	function logStatement(statement:Statement):Void;
	
	/**
	 * Called when a branch code block is executed at runtime.
	 *  
	 * @param	block		a code block  
	 */
	function logBranch(branch:Branch):Void;
	
	/**
	 * Called when all tests are complete.
	 *  
	 * @param	allClasses	arrgregated coverage data containing all statements, branches orded by package/file/class/method
	 * @see massive.mcover.data.AllClasses;
	 */
	function report(allClasses:AllClasses):Void;

}