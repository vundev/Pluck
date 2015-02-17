package api.views 
{
	import flash.text.TextField;
	import pluck.core.View;
	import flash.utils.getTimer
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class Screen extends View
	{
		protected var _label:TextField
		protected var _timestamp:TextField
		
		public function Screen(label:String = null) 
		{
			_label = new TextField()
			_label.border = true
			_label.autoSize = 'left';
			_label.text = label
			
			_timestamp = new TextField()
			_timestamp.border = true
			_timestamp.autoSize = 'left';
			_timestamp.text = 'timestamp: ' + getTimer();
			_timestamp.x = 200;
			
			changeColor(0xff0000)
			
			append(_label, _timestamp)
		}
		
		public function set label(value:String):void 
		{
			_label.text = value
		}
		
		public function changeColor(color:uint):void
		{
			this.graphics.clear()
			this.graphics.beginFill(color)
			this.graphics.drawRect(0, 0, 300, 400)
			this.graphics.endFill()
		}
	}

}