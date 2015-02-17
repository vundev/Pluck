package api.controllers 
{
	import api.views.Screen;
	import pluck.core.Notification;
	import pluck.core.ViewController;
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class ScreenController extends ViewController
	{
		
		public function ScreenController() 
		{
			
		}
		
		override public function onRegister():void 
		{
			_view = new Screen('screen')
			checkForInitialAttrs()
			view.y = 100;
		}
		
		override public function get interests():Array 
		{
			return [ColorPickerController.CHANGE_COLOR];
		}
		
		override public function handleNotification(notification:Notification):void 
		{
			super.handleNotification(notification);
			switch (notification.type) 
			{
				case ColorPickerController.CHANGE_COLOR:
					view.changeColor(notification.body.color)
				break;
			}
		}
		
		private function get view():Screen { return _view as Screen; }
	}

}