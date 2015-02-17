package pluck.utils
{
	import pluck.utils.External;
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class MessageSubComplex extends External
	{
		public var data:Array
		
		public function MessageSubComplex(data:Array = null) 
		{
			this.data = data
		}
		
		public function toString():String
		{
			return '{ data: ' + this.data + '}';
		}
	}

}