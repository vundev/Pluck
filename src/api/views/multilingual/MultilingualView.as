package api.views.multilingual 
{
	import pluck.core.View
	import flash.display.Sprite;
	import pluck.display.PLTextField;
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class MultilingualView extends View
	{
		public var langButtons:Sprite = new Sprite()
		private var _label:PLTextField = new PLTextField()
		
		public function MultilingualView(text:*, langs:Array) 
		{
			const length:uint = langs.length;
			for (var i:int = 0; i < length; i++) 
			{
				var item:Sprite = new Sprite();
				item.graphics.beginFill(0xff0000)
				item.graphics.drawRect(0, 0, 44, 44)
				item.graphics.endFill()
				item.name = langs[i];
				langButtons.addChild(item)
				item.x = i * (item.width + 2);				
			}
			
			_label.x = langButtons.width + 2;
			_label.mText = text
			
			append(langButtons, _label)
		}
		
		override public function dispose():void 
		{
			super.dispose();
			_label.dispose()
		}
	}

}