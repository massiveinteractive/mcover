package massive.mcover.data;

@:keep class Branch extends AbstractBlock
{
	public var trueCount:Int;
	public var falseCount:Int;

	public var totalCount(get_totalCount, null):Int;

	public function new()
	{
		super();
		trueCount = 0;
		falseCount = 0;
	}

	function get_totalCount():Int
	{
		return trueCount + falseCount;
	}

	override public function isCovered():Bool
	{
		return trueCount > 0 && falseCount > 0;
	}

	override public function toString():String
	{
		var s:String = super.toString();
		if(!isCovered())
		{
			s += " | ";
			if(trueCount == 0) s += "t";
			if(trueCount == 0 && falseCount == 0) s +=",";
			if(falseCount == 0) s += "f";
		
		}
		return s;
	}

		///////////

	override function hxSerialize( s : haxe.Serializer )
	{
		super.hxSerialize(s);
        s.serialize(trueCount);
        s.serialize(falseCount);
    }
    
    override function hxUnserialize( s : haxe.Unserializer )
    {
    	super.hxUnserialize(s);
        trueCount = s.unserialize();
        falseCount = s.unserialize();
    }
}

typedef BranchResult =
{
	id:Int,
	value:Bool,//current value
	result:String,//binary string reprentation of true and false coverage ("00")
	trueCount:Int,
	falseCount:Int,
	total:Int, //total true and false counts;
}
