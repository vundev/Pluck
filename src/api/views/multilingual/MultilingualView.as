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
			
			const labelBackground:Sprite = new Sprite()
			labelBackground.graphics.beginFill(0xff0000)
			labelBackground.graphics.drawRect(0, 0, 100, 30)
			labelBackground.graphics.endFill()			
			labelBackground.x = langButtons.width + 2
			
			_label.border = true;
			_label.autoSize = 'left';
			_label.onLanguageChangeCompletion = function(lang:String):void {
				_label.x = (labelBackground.width - _label.width) / 2 + labelBackground.x;
				_label.y = (labelBackground.height - _label.height) / 2 + labelBackground.y;
			}
			_label.mText = text
			
			append(langButtons, labelBackground, _label)
		}
		
		override public function dispose():void 
		{
			super.dispose();
			_label.dispose()
		}
	}

}