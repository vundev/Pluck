package pluck.utils 
{
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class ArrayUtils 
	{
		
		public function ArrayUtils() 
		{
			throw new Error('static class')
		}
		
		public static function has(collection:*, what:*):Boolean
		{
			return collection.indexOf(what) >= 0
		}
		
		public static function diff(array:*, compare:*):Array
		{
			const unique:Array = []
			const length:uint = array.length
			for (var i:int = 0; i < length; i++) 
				if (!has(compare, array[i])) unique.push(array[i])
			return unique
		}
		
		public static function random(amount:uint, range:uint):Array
		{
			if (amount > range)
				throw new Error('Amount of random numbers must be less then or equals to the rage.')
				
			const result:Array = []
			
			// creates an array from numbers 1, ..., range
			const setOfNumbers:Array = []
			for (var i:int = 0; i < range; i++) 
				setOfNumbers[i] = i + 1
				
			for (i = 0; i < amount; i++) 
			{
				var randomIndex:uint = Math.floor(Math.random() * setOfNumbers.length)
				result.push(int(setOfNumbers.splice(randomIndex, 1)))
			}
			
			return result
		}
		
		public static function intersect(array1:*, array2:*):Array
		{
			const intersection:Array = []
			const length:uint = array1.length
			for (var i:int = 0; i < length; i++) 
				if (has(array2, array1[i])) intersection.push(array1[i])
			return intersection
		}
		
		public static function last(collection:*):*
		{
			return collection[collection.length - 1];
		}
	}

}