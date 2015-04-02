package pluck.core 
{
	import flash.events.EventDispatcher;
	import pluck.events.LanguageEvent;
	import pluck.utils.Hash;

	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class RootModel extends EventDispatcher
	{
		private var _lang:String = 'en';
		private var _currentPage:String
		private var _currentParameters:Hash = new Hash()
		
		public function RootModel() 
		{
			
		}
		
		public function goToPage(page:String, parameters:Object = null):Boolean
		{
			const params:Hash = new Hash(parameters)
			if (_currentPage != page || !_currentParameters.equals(params)) {
				_currentPage = page
				_currentParameters = params
				return true
			}
			return false
		}
		
		public function set lang(value:String):void 
		{
			if (_lang != value) {
				_lang = value;
				dispatchEvent(new LanguageEvent(LanguageEvent.CHANGE, value))
			}
		}
		
		public function get lang():String { return _lang; }
		public function get currentPage():String { return _currentPage; }
		public function get currentParameters():Hash { return _currentParameters; }
	}

}