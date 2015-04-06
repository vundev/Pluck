package pluck.display 
{
	import flash.events.Event;
	import flash.text.TextField;
	import pluck.core.IDisposable;
	import pluck.core.RootModel;
	import pluck.events.LanguageEvent
	import pluck.core.ViewController
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class PLTextField extends TextField implements IDisposable
	{
		private var _rootModel:RootModel 
		private var _mText:XMLList
		public var onLanguageChangeCompletion:Function
		
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
			text = translate(_mText, _rootModel.lang)
			if (this.onLanguageChangeCompletion != null)
				onLanguageChangeCompletion.call(this, _rootModel.lang)
		}
		
		public function set mText(value:*):void 
		{
			if (value is XMLList && _rootModel) {
				_mText = value;		
				onLanguageChange()			
			}
			else text = value
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
	}

}