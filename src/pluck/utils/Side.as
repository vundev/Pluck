package pluck.utils 
{
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class Side 
	{
		private var _width:Number = 0
		private var _height:Number = 0
		private var _ratio:Number = 0
		
		public function Side(width:Number, height:Number) 
		{
			_width = width
			_height = height
			
			_ratio = width / height
		}
		
		public function constrain(w:Number, h:Number):Side { 			
			if((w/h) < _ratio) this.width = w				
			else this.height = h
			return this
		}
		
		public function toString():String
		{
			return '[Side width=' + this.width + ', height: ' + this.height + ']';
		}
		
		public function set width(w:Number):void { 
			this._height = w / _ratio
			this._width = w
		}
		
		public function get width():Number { return _width; }
		
		public function set height(h:Number):void {
			this._width = h * _ratio
			this._height = h
		}
		
		public function get height():Number { return _height; }
	}

}