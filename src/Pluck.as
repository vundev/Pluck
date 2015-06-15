package {
	import api.controllers.NavigationController;
	import api.controllers.RootController;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
    import flash.display.Sprite;
	import pluck.core.View;
	import pluck.core.ViewController;
	import flash.utils.getQualifiedClassName
	import api.events.GameEvent
	import com.greensock.loading.LoaderMax
	import pluck.core.RootModel

    public class Pluck extends View 
	{
		public var events:Object = { }
		public var exitButton:Sprite = new Sprite()
		
        public function Pluck() 
		{
            trace(">> Pluck Instantiated!", RootModel.VERSION);
			
			events[getQualifiedClassName(GameEvent)] = { event:GameEvent, types:[GameEvent.HIDE_GAME] }
			
			ViewController.root = new RootController(this)
				
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
			ViewController.disposeRootController()
		}
    }
}

