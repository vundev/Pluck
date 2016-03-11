package pluck.core 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	internal class DisplayObjectController implements IDisposable
	{
		protected var _view:View
		// visual properties of the view set before its creation from outside of the controller
		private var _initialAttrs:Object
		
		public function DisplayObjectController(view:View = null) 
		{
			_view = view 
		}
		
		public function setZIndex(index:uint):void
		{
			const numChildren:int = _view.parent.numChildren
			if (index >= numChildren)
				index = numChildren - 1
			_view.parent.setChildIndex(_view, index)
		}
		
		public function attrs(properties:Object):DisplayObjectController
		{
			if (_view) {
				for (var name:String in properties) 
					_view[name] = properties[name];
			}
			else _initialAttrs = properties
			return this
		}
		
		public function swap(c1:DisplayObjectController, c2:DisplayObjectController):void
		{
			if (c1._view.parent && c1._view.parent == c2._view.parent) 
				c1._view.parent.swapChildren(c1._view, c2._view)
		}
		
		/**
		 * Check if there are initial properties for the view set before its creation, if so the calling of this method after view's creation will
		 * update those properties of the view. If there are no initial attrs to be set later this method will do nothing.
		 */
		protected function checkForInitialAttrs():void
		{
			this.attrs(_initialAttrs)
		}
		
		public function dispose():void
		{
			
		}
	}

}