package pluck.core 
{
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class TestNotificationsViewController extends ViewController
	{
		public static const NOTIFICATION_TYPE:String = 'notificationType';
		
		public function TestNotificationsViewController() 
		{
			super(new View(), new TestNotificationsModel())
		}
		
		override public function get interests():Array 
		{
			return [NOTIFICATION_TYPE]
		}
		
		override public function handleNotification(notification:Notification):void 
		{
			super.handleNotification(notification);
			const model:TestNotificationsModel = this.model as TestNotificationsModel;
			if (notification.type == NOTIFICATION_TYPE) {
				model.notificationAccepted = true
			}
		}
		
		public function get model():TestNotificationsModel { return _model as TestNotificationsModel; }
	}

}