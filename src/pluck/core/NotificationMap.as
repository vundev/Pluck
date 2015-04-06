package pluck.core 
{
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	internal class NotificationMap 
	{
		private var _data:Object = { }
		
		public function NotificationMap() 
		{
			
		}
		
		private function registerRecipient(notificationType:String, controller:ViewController):void
		{
			if (notificationType in _data) {
				const recipients:Vector.<ViewController> = this.getRecipients(notificationType)
				recipients.push(controller)
			}else {
				_data[notificationType] = new Vector.<ViewController>();
				_data[notificationType][0] = controller
			}
		}
		
		public function register(controller:ViewController):void
		{
			const interests:Array = controller.interests
			const length:uint = interests.length
			for (var i:int = 0; i < length; i++) 
				registerRecipient(interests[i], controller)
		}
		
		public function unregister(controller:ViewController):void
		{
			const interests:Array = controller.interests;
			const length:uint = interests.length
			for (var i:int = 0; i < length; i++) 
			{
				const recipients:Vector.<ViewController> = this.getRecipients(interests[i])
				recipients.splice(recipients.indexOf(controller), 1)
			}
		}
		
		public function notify(notification:Notification):void
		{
			var recipients:Vector.<ViewController> = this.getRecipients(notification.type)
			if (recipients) {
				recipients = recipients.concat()
				const length:uint = recipients.length
				for (var i:int = 0; i < length; i++) 
					recipients[i].handleNotification(notification)
			}			
		}
		
		private function getRecipients(notificationType:String):Vector.<ViewController>
		{
			return _data[notificationType] as Vector.<ViewController>;
		}
	}

}