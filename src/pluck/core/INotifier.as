package pluck.core 
{
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public interface INotifier 
	{
		function sendNotification(type:String, body:Object = null):void
	}
	
}