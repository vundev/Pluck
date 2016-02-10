package pluck.utils 
{
	import flash.utils.getQualifiedClassName
	import flash.utils.getDefinitionByName
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
		
		static public function flatten(array:Array):Array 
		{
			var flattened:Array = new Array()
			const length:uint = array.length
			for (var i:int = 0; i < length; i++) 
			{
				if (array[i] is Array) flattened = flattened.concat(flatten(array[i]))
				else flattened.push(array[i])
			}
			return flattened
		}
		
		public static function length(array:*):uint
		{
			if (array is Array)
				return array.length
			var length:uint
			for each (var item:* in array) 
				length++
			return length
		}
		
		public static function randomFromArray(amount:uint, array:Array):Array
		{
			if (amount > array.length)
				throw new Error('Amount of random elements must be less then or equals to the array length.')
			const result:Array = []
			const copy:Array = array.concat()
			const length:uint = copy.length
			var counter:uint
			for (var i:int = 0; i < length; i++) 
			{
				if (counter < amount) {					
					result.push(copy.splice(Math.floor(Math.random() * copy.length), 1)[0])
					counter++
				}				
			}
			return result
		}
		
		public static function integersTo(n:uint, start:int = 0):Array
		{
			const result:Array = []
			for (var i:int = 0; i < n; i++) 
				result[i] = i + start
			return result
		}
		
		public static function isVector(v:*):Boolean
		{
			return (v as Vector.<*>) is Vector.<*>
		}
		
		public static function getVectorType(v:*):Class
		{
			const vectorName:String = getQualifiedClassName(v)			
			return getDefinitionByName(vectorName.substring(21, vectorName.length - 1)) as Class;
		}
		
		/**
		 * The best way to print arrays with commas and braces (deals with multi-arrays like a charm).
		 * @param	array
		 * @return
		 */
		public static function print(array:Array):String
		{
			var output:String = '';
			const length:uint = array.length
			for (var i:int = 0; i < length; i++) 
			{
				var comma:String = i == length - 1 ? '' : ',';
				var element:* = array[i]
				if (element is Array) output += print(element) + comma
				else if (getQualifiedClassName(element) === "Object")
					output += new Hash(element).toString() + comma;
				else output += element + comma
			}
			return '[' + output + ']';
		}
		
		public static function printArrayOfComplex(array:Array):String
		{
			return array.map(function(e:*, i:int, a:Array):String { return JSON.stringify(e) } ).join(',\n')
		}
	}

}