package api.models 
{
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class ColorPickerModel 
	{
		private static var _objectID:int
		
		public function ColorPickerModel()
		{
			_objectID++
		}
		
		public function get objectID():int { return _objectID; }
	}

}