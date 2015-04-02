package api.controllers 
{
	import api.views.navigation.Navigation;
	import flash.events.MouseEvent;
	import pluck.core.ViewController;
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class NavigationController extends ViewController
	{
		
		public function NavigationController() 
		{
			
		}
		
		override public function onRegister():void 
		{
			_view = new Navigation(2)
			view.addEventListener(MouseEvent.CLICK, onClickNavigationItem)
		}
		
		private function onClickNavigationItem(event:MouseEvent):void
		{
			sendNotification(RootController.START_PAGE_CHANGE, { page:'screen' + event.target.name } )
		}
		
		override public function dispose():void 
		{
			super.dispose();
			view.removeEventListener(MouseEvent.CLICK, onClickNavigationItem)
		}
		
		private function get view():Navigation { return _view as Navigation; }
	}

}