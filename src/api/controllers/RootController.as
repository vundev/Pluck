package api.controllers 
{
	import api.events.GameEvent;
	import api.models.AppModel;
	import flash.events.MouseEvent;
	import pluck.core.Notification;
	import pluck.core.View;
	import pluck.core.ViewController;
	import pluck.utils.ArrayUtils
	import com.greensock.events.LoaderEvent
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class RootController extends ViewController
	{
		public static const START_PAGE_CHANGE:String = 'startPageChange';
		public static const START_LANG_CHANGE:String = 'startLangChange';
		
		public function RootController(documentClass:View) 
		{
			super(documentClass)
			view.exitButton.addEventListener(MouseEvent.CLICK, onExitClick)
			autoDispose = false
		}
		
		override public function onRegister():void 
		{
			_model = new AppModel();
			model.langs = ['bg', 'en', 'ru'];
			model.lang = 'en';
			model.loader.addEventListener(LoaderEvent.COMPLETE, onLoadContent)
			model.loader.load()
		}
		
		private function onLoadContent(event:LoaderEvent):void
		{
			sendNotification(RootController.START_PAGE_CHANGE, { page:'screen0' } )
		}
		
		private function onExitClick(event:MouseEvent):void
		{
			view.loaderInfo.sharedEvents.dispatchEvent(new GameEvent(GameEvent.HIDE_GAME))
		}
		
		override public function get interests():Array 
		{
			return [START_PAGE_CHANGE, START_LANG_CHANGE]
		}
		
		override public function handleNotification(notification:Notification):void 
		{
			switch (notification.type) 
			{
				case START_PAGE_CHANGE:
					if (model.goToPage(notification.body.page)) {
						//TODO: Think about animations
						// - for each controller there are 2 types of animations: default animation, specific animation if the previous page was ...
						// - attrs may execute function of the view => view.fadeIn(1) <=> controller.attrs({fadeIn:{time:1}})
						switch (model.currentPage) 
						{
							case 'screen0':
								setControllers(
									new NavigationController().unique,
									new ScreenController().unique.attrs( { x:88 } ),
									new MultilingualController().unique.attrs( { x:500 } )
								)
							break;
							case 'screen1':
								setControllers(
									new NavigationController().unique, // This is fast because the view of this new instance of the controller is not created.
																	   // This empty controller is used to give you a reference to the first instance of the NavigationController.	
									new ScreenController().unique.attrs( { x:200 } ),
									new ColorPickerController(),
									new MultilingualController().unique.attrs( { x:500 } )
								)
							break;
						}
					}
				break;
				case START_LANG_CHANGE:
					model.lang = notification.body.lang;
				break;
				default:
					
				break;
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
			model.dispose()
		}
		
		private function get view():Pluck { return _view as Pluck; }
		public function get model():AppModel { return _model as AppModel; }
	}

}