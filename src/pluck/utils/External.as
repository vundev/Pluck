package pluck.utils 
{
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
					this[name] = withObject[name]
				}
			}
			return this
		}
	}

}