package api.views.navigation 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class NavigationItem extends Sprite
	{
		protected var _label:TextField
		
		public function NavigationItem(label:String) 
		{
			_label = new TextField()
			_label.border = true
			_label.autoSize = 'left';
			_label.text = label
			const textFormat:TextFormat = new TextFormat()
			textFormat.size = 28
			_label.setTextFormat(textFormat)
			
			this.graphics.beginFill(0xff0000)
			this.graphics.drawRect(0, 0, _label.width, _label.height)
			this.graphics.endFill()
			
			addChild(_label)
			
			mouseChildren = false;
			buttonMode = true
			name = label
		}
		
	}

}