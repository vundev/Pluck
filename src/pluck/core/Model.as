package pluck.core 
{
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class Model implements INotifier, IDisposable
	{
		/**
		 * Blueprint of a model which could send notifications.
		 */
		public function Model() 
		{
			
		}
		
		public function sendNotification(type:String, body:Object = null):void
		{
			ViewController.root.sendNotification(type, body)
		}
		
		public function dispose():void { }
	}

}