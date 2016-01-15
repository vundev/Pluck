package pluck.display 
{
	import flash.events.Event;
	import flash.text.TextField;
	import pluck.core.IDisposable;
	import pluck.core.RootModel;
	import pluck.events.LanguageEvent
	import pluck.core.ViewController
	import flash.text.TextFormat
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class PLTextField extends TextField implements IDisposable
	{
		public static const MIN_FONT_SIZE:uint = 4;
		private var _rootModel:RootModel 
		private var _mText:XMLList
		public var onLanguageChangeCompletion:Function
		public var html:Boolean
		
		public function PLTextField() 
		{
			try {
				_rootModel = Object(ViewController.root).model as RootModel;
				_rootModel.addEventListener(LanguageEvent.CHANGE, onLanguageChange)
			}
			catch (error:Error) {/*do nothing*/}			
		}
		
		private function onLanguageChange(event:LanguageEvent = null):void
		{
			if(html) htmlText = translate(_mText, _rootModel.lang)
			else text = translate(_mText, _rootModel.lang)
			if (this.onLanguageChangeCompletion != null)
				onLanguageChangeCompletion.call(this, _rootModel.lang)
		}
		
		public function set mText(value:*):void 
		{
			if (value is XMLList && _rootModel) {
				_mText = value;		
				onLanguageChange()			
			}
			else {
				if(html) htmlText = value
				else text = value
			}
		}
		
		public function dispose():void
		{
			if (_rootModel) {
				_rootModel.removeEventListener(LanguageEvent.CHANGE, onLanguageChange)
				_rootModel = null;
			}			
		}
		
		public static function translate(value:*, lang:String):String
		{
			if (value is XMLList)
			{
				value = value.(@lang == lang);
				return value && value.length() ? value[0] : 'not translated' 
			}
			return value
		}
		
		private function stretch(prop:String, max:Number):void
		{
			if (max <= 0) return;
			const format:TextFormat = this.getTextFormat()
			while (this[prop] < max) {
				format.size = int(format.size) + 1
				this.setTextFormat(format)
			}
			while (this[prop] > max) {
				if (format.size == MIN_FONT_SIZE) break;
				format.size = int(format.size) - 1
				this.setTextFormat(format)
			}
		}
		
		public function constrain(w:Number, h:Number):PLTextField
		{
			const ratio:Number = this.width / this.height
			if ((w / h) < ratio) {
				stretch('width', w)
			}else {
				stretch('height', h)
			}
			return this
		}
	}

}