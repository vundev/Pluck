package pluck.core 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class View extends Sprite implements IDisposable
	{
		private var _interactive:Boolean = true
		
		public function View() 
		{
			
		}
		
		public function append(...args):void
		{
			for each (var item:DisplayObject in args) 
				addChild(item)
		}
		
		public function get interactive():Boolean { return _interactive; }
		
		public function set interactive(value:Boolean):void 
		{
			_interactive = value
			mouseChildren = mouseEnabled = _interactive
		}
		
		public function dispose():void
		{
			
		}
	}

}