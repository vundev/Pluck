package pluck.core 
{
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class Notification 
	{
		public var type:String
		public var body:Object
		
		public function Notification(type:String, body:Object = null) 
		{
			this.type = type
			this.body = body
		}
		
		public function toString():String
		{
			return '[Notification type=' + type+', body=' + body + ']';
		}
	}

}