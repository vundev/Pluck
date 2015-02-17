package api.views.color_picker 
{
	import flash.text.TextField;
	import pluck.core.View;
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class ColorPicker extends View
	{
		public function ColorPicker(id:int) 
		{
			const idLabel:TextField = new TextField()
			idLabel.autoSize = 'left';
			idLabel.border = true;
			idLabel.text = String(id)
			
			graphics.beginFill(0xff0000)
			graphics.drawRect(0, 0, 88, 88)
			graphics.endFill()
			
			buttonMode = true
			mouseChildren = false;
			
			addChild(idLabel)
		}
		
	}

}