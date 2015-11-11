package pluck.utils
{
	import pluck.utils.External;
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class Message extends External
	{
		public var command:String
		public var complex:MessageComplex
		/** This is a key which is not serialized. **/
		public var doesNotParticipate:String = 'doesNotParticipate';
		public var vector:Vector.<VectorItem> = new Vector.<VectorItem>()
		
		public function Message(command:String = null, complex:MessageComplex = null) 
		{
			this.command = command
			this.complex = complex || new MessageComplex()
		}
		
		public function toString():String
		{
			return '[Message command: ' + this.command + ', complex: ' + this.complex + ']'
		}
	}

}