package pluck.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class LanguageEvent extends Event 
	{
		public static const CHANGE:String = 'onLanguageChange';
		
		public var lang:String
		
		public function LanguageEvent(type:String, lang:String = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			this.lang = lang
		} 
		
		public override function clone():Event 
		{ 
			return new LanguageEvent(type, lang, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LanguageEvent", "type", "lang", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}