package pluck.utils 
{
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class StringUtils 
	{
		
		public function StringUtils() 
		{
			throw new Error('static class')
		}
		
		public static function prefix(what:*, to:*= '', amount:uint = 0):String
		{
			var prefix:String = '';
			for (var i:int = 0; i < amount; i++) 
				prefix += what;
			return prefix.concat(to);
		}
	}

}