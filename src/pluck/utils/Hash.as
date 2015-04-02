package pluck.utils 
{
	import flash.utils.getQualifiedClassName
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public dynamic class Hash 
	{
		
		public function Hash(obj:Object = null) {
			if (obj) this.merge(obj)
		}
		
		public function merge(obj:Object, recursive:Boolean = true):Hash {
			for (var name:String in obj) {
				if( obj[name] !== null){
					var base_class:String = getQualifiedClassName(this[name])
					var merge_class:String = getQualifiedClassName(obj[name])
					if (recursive && ( base_class === 'Object' || base_class === "pluck.utils::Hash") && ( merge_class === 'Object' || merge_class === "pluck.utils::Hash" )) this[name] = new Hash(this[name]).merge(obj[name], recursive)
					else this[name] = obj[name]
				}
			}
			return this
		}
		
		public function equals(other:Hash):Boolean {
			var name:String
			for (name in this) if (this[name] != other[name]) return false
			for (name in other) if (other[name] != this[name]) return false
			return true
		}
		
	}

}