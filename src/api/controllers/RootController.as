package api.controllers 
{
	import api.events.GameEvent;
	import flash.events.MouseEvent;
	import pluck.core.Notification;
	import pluck.core.View;
	import pluck.core.ViewController;
	import pluck.utils.ArrayUtils
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class RootController extends ViewController
	{
		public static const CHANGE:String = 'change';
		private var _currentPage:String
		
		public function RootController(documentClass:View) 
		{
			super(documentClass)
			view.exitButton.addEventListener(MouseEvent.CLICK, onExitClick)
			autoDispose = false
		}
		
		private function onExitClick(event:MouseEvent):void
		{
			view.loaderInfo.sharedEvents.dispatchEvent(new GameEvent(GameEvent.HIDE_GAME))
		}
		
		override public function get interests():Array 
		{
			return [CHANGE]
		}
		
		override public function handleNotification(notification:Notification):void 
		{
			if (notification.type == CHANGE) {
				if (_currentPage != notification.body.page) {
					_currentPage = notification.body.page
					//TODO: Think about animations
					// - for each controller there are 2 types of animations: default animation, specific animation if the previous page was ...
					// - attrs may execute function of the view => view.fadeIn(1) <=> controller.attrs({fadeIn:{time:1}})
					switch (_currentPage) 
					{
						case 'screen0':
							setControllers(
								new NavigationController().unique,
								new ScreenController().unique.attrs( { x:88 } )
							)
						break;
						case 'screen1':
							setControllers(
								new NavigationController().unique, // This is fast because the view of this new instance of the controller is not created.
																   // This empty controller is used to give you a reference to the first instance of the NavigationController.	
								new ScreenController().unique.attrs( { x:200 } ),
								new ColorPickerController()
							)
						break;
					}
				}
			}
		}
		
		private function setControllers(...args):void
		{
			var length:uint = args.length
			for (var i:int = 0; i < length; i++) 
				this.addChildViewController(ViewController(args[i]))
				
			const rest:Array = ArrayUtils.diff(this.children, args)
			length = rest.length
			for (i = 0; i < length; i++) 
				this.removeChildViewController(ViewController(rest[i]))
		}
		
		override public function dispose():void 
		{
			super.dispose();
			view.exitButton.removeEventListener(MouseEvent.CLICK, onExitClick)
		}
		
		private function get view():Pluck { return _view as Pluck; }
	}

}