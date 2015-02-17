package pluck.utils
{
	import pluck.utils.External;
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class MessageComplex extends External
	{
		public var subCommand:String
		public var subComplex:MessageSubComplex
		
		public function MessageComplex(subCommand:String = null, subComplex:MessageSubComplex = null) 
		{
			this.subCommand = subCommand
			this.subComplex = subComplex || new MessageSubComplex()
		}
		
		public function toString():String
		{
			return '{ subCommand: ' + this.subCommand +', subComplex:' + this.subComplex + '}';
		}
		
	}

}