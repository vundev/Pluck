package pluck.utils 
{
	import flash.utils.ByteArray
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class ClassUtils 
	{
		
		public function ClassUtils() 
		{
			throw new Error('static class')
		}
		
		public static function clone(object:Object, deep:Boolean = true):*
		{
			if(deep) {
				var bytes:ByteArray = new ByteArray()
				bytes.writeObject(object)
				bytes.position = 0
				return bytes.readObject()
			}
			const clone:Object = { }
			for (var name:String in object) 
				clone[name] = object[name]
			return clone
		}
		
	}

}