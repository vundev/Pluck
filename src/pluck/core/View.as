package pluck.core 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import pluck.utils.ArrayUtils
	
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
			const list:Array = ArrayUtils.flatten(args)
			for each (var item:DisplayObject in list) 
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