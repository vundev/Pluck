package api.models 
{
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class ColorPickerModel 
	{
		private static var _objectID:int
		private var _id:int
		
		public function ColorPickerModel()
		{
			_id = _objectID++
		}
		
		public function get id():int { return _id; }
	}

}