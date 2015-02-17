package {
	import api.controllers.NavigationController;
	import api.controllers.RootController;
    import flash.display.Sprite;
	import pluck.core.View;
	import pluck.core.ViewController;
	import flash.utils.getQualifiedClassName
	import api.events.GameEvent

    public class Pluck extends View 
	{
		public var events:Object = { }
		public var exitButton:Sprite = new Sprite()
		private var _rootController:RootController
		
        public function Pluck() 
		{
            trace(">> Pluck Instantiated!");
			
			events[getQualifiedClassName(GameEvent)] = { event:GameEvent, types:[GameEvent.HIDE_GAME] }
			
			_rootController = new RootController(this).registerAsRootViewController() as RootController;
			_rootController.sendNotification(RootController.CHANGE, { page:'screen0' } )
			
			exitButton.graphics.beginFill(0x000000)
			exitButton.graphics.drawRect(0, 0, 88, 88)
			exitButton.graphics.endFill()
			exitButton.buttonMode = true
			exitButton.x = 400;
			addChild(exitButton)
        }
		
		public function set data(value:Object):void 
		{
			
		}
		
		override public function dispose():void 
		{
			super.dispose();
			_rootController.unregisterThisRootViewController()
			_rootController = null
		}
    }
}

