package pluck.core 
{
	import flash.display.DisplayObject;
	import pluck.core.DisplayObjectController
	import pluck.utils.ArrayUtils
	import flash.utils.getQualifiedClassName
	import pluck.utils.ClassUtils
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class ViewController extends DisplayObjectController implements INotifier
	{
		protected var _model:Object
		private var _name:String
		private static var _controllerMap:Object = { }
		private static var _notificationMap:NotificationMap = new NotificationMap()
		private static var _root:ViewController
		private var _children:Vector.<ViewController> = new Vector.<ViewController>()
		private var _parent:ViewController
		private var _autoDispose:Boolean = true
		
		public function ViewController(view:View = null, model:Object = null, name:String = null)
		{
			super(view)
			_model = model
			_name = getQualifiedClassName(this) + (name ? '_' + name : '')
		}
		
		public function sendNotification(type:String, body:Object = null):void
		{
			_notificationMap.notify(new Notification(type, body))
		}
		
		public function handleNotification(notification:Notification):void { }
		
		public function broadcast(type:String, body:Object = null):void
		{
			const notification:Notification = new Notification(type, body)
			// use copy of the map to prevent from for-each problems just in case when a controller is unregistered; 
			// must not delete keys while iterrating through an associative array;
			const controllerMap:Object = ClassUtils.clone(_controllerMap, false)
			for each (var item:ViewController in controllerMap) 
				item.handleNotification(notification)
		}
	
		public function onRegister():void { }
		
		public function onUnregister():void { }
		
		public function addChildViewController(child:ViewController):ViewController
		{
			if (!hasChildViewController(child)) {
				// create the tree structure 
				_children.push(child)
				child._parent = this
				// register to map
				_controllerMap[child.name] = child
				// register to notification map
				_notificationMap.register(child)
				child.onRegister()
				// add the view to the display list
				_view.addChild(child._view)
			}
			return child
		}
		
		public function removeChildViewController(child:ViewController):void
		{
			if (hasChildViewController(child)) {
				while (child.children.length > 0) 
					child.removeChildViewController(child.children[0])
				// removes the child from the tree structure starting from the leafs
				_children.splice(_children.indexOf(child), 1)
				child._parent = null
				// removes the child from the map
				delete _controllerMap[child.name]
				// removes the child from the notification map
				_notificationMap.unregister(child)
				child.onUnregister()
				// dispose child immediately if set to autoDispose=true
				if (child.autoDispose)
					child.destroy()
				else child._view.interactive = false
			}
		}
		
		public function hasChildViewController(child:ViewController):Boolean
		{
			return ArrayUtils.has(_children, child)
		}
		
		public function getController(name:String):ViewController
		{
			if (_controllerMap[name] == undefined)
				return null
			return _controllerMap[name]
		}
		
		public function getControllerByClass(c:Class, sufix:String = null):ViewController { 			
			return getController(getQualifiedClassName(c) + (sufix || ''))
		}
		
		public static function disposeRootController():void
		{
			while (_root.children.length > 0)
				_root.removeChildViewController(_root.children[0])
			delete _controllerMap[_root.name];
			_notificationMap.unregister(_root)
			_root.onUnregister()
			_root.dispose()
			const rootModel:*= _root._model
			if (rootModel && 'dispose'in rootModel) rootModel.dispose()
			_root = null
		}
		
		/**
		 * Must call this method manually at the end of the view's hide animation to dispose the view/controller 
		 * (controller.autoDispose must be set to false not later then onUnregister call).
		 */
		protected final function destroy():void
		{
			// removes the view from the display list
			if(_view.parent && _view.parent.contains(_view))
				_view.parent.removeChild(_view)					
			dispose()
			_view.dispose()
			if (_model && 'dispose' in _model) _model.dispose()
			_view = null
			_model = null
		}
		
		public static function set root(value:ViewController):void 
		{
			if (_root) throw new Error('Root controller has been already set!')
			_root = value
			// register root controller for handling notifications
			_controllerMap[_root.name] = _root
			_notificationMap.register(_root)
			_root.onRegister()
		}
		
		public static function get root():ViewController { return _root; }
		
		public function get interests():Array { return [] }
		
		public function get name():String { return _name; }
		
		public function get parent():ViewController { return _parent }
		
		public function get children():Vector.<ViewController> { return _children }
		
		public function get autoDispose():Boolean { return _autoDispose; }
		
		public function set autoDispose(value:Boolean):void { _autoDispose = value }
		
		public function get unique():ViewController { return getController(this.name) || this; }
	}

}