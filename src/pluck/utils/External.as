package pluck.utils 
{
	import pluck.utils.ArrayUtils
	import flash.utils.getQualifiedClassName
	import flash.utils.getDefinitionByName
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class External implements ISerializable
	{
		public final function serialize(withObject:Object):ISerializable
		{
			if (withObject == null) return null
			const clone:Object = ClassUtils.clone(this)
			for (var name:String in clone) 
			{
				if (this[name] is ISerializable) {
					(this[name] as ISerializable).serialize(withObject[name]);
				}
				else if (name in withObject) { 
					// map an array of complex items with vector with serializable items
					if (ArrayUtils.isVector(this[name])) {
						var length:uint = withObject[name].length
						var vectorType:Class = ArrayUtils.getVectorType(this[name])
						for (var i:int = 0; i < length; i++) 
						{
							this[name][i] = new vectorType()
							ISerializable(this[name][i]).serialize(withObject[name][i])
						}
					}
					else this[name] = withObject[name]
				}
			}
			return this
		}
	}

}