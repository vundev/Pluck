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
	public class ViewController extends DisplayObjectController
	{
		protected var _model:Object
		private var _name:String
		//TODO: make possible to dispose controller map
		private static var _controllerMap:Object = { }
		private static var _notificationMap:NotificationMap = new NotificationMap()
		private var _children:Vector.<ViewController> = new Vector.<ViewController>()
		private var _parent:ViewController
		private var _autoDispose:Boolean = true
		private var _isRootController:Boolean
		
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
		
		public function broadcast(type:String, body:Object = null, keepOrder:Boolean = false):void
		{
			const notification:Notification = new Notification(type, body)
			if (keepOrder)
			{
				for each (var item:ViewController in _controllerMap) 
					if (item._isRootController) 
						broadcastFrom(item, notification)
			}
			else
			{
				// use copy of the map to prevent from for-each problems just in case when a controller is unregistered; 
				// must not delete keys while iterrating through an associative array;
				const controllerMap:Object = ClassUtils.clone(_controllerMap, false)
				for each (item in controllerMap) 
					item.handleNotification(notification)
			}
		}
		
		private function broadcastFrom(root:ViewController, notification:Notification):void
		{
			root.handleNotification(notification)
			const length:uint = root.children.length
			for (var i:int = 0; i < length; i++) 
				broadcastFrom(root.children[i], notification)
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
			trace('remove child ' + child, hasChildViewController(child))
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
		
		/** Make possible to have more than one root controllers for diff kinds of display lists(native, stage3d, in js - native, canvas). **/
		public function registerAsRootViewController():ViewController
		{
			if (!this._isRootController) {
				this._isRootController = true;
				// register root controller for handling notifications
				_controllerMap[this.name] = this
				_notificationMap.register(this)
				this.onRegister()
			}
			return this
		}

		public function unregisterThisRootViewController():void
		{
			if (this._isRootController) {
				while (this.children.length > 0)
					this.removeChildViewController(this.children[0])
				delete _controllerMap[this.name];
				_notificationMap.unregister(this)
				this.onUnregister()
				if (this.autoDispose)
					this.destroy()
				else _view.interactive = false
			}
		}
		
		/**
		 * Must call this method manually at the end of the view's hide animation to dispose the view/controller 
		 * (controller.autoDispose must be set to false not later then onUnregister call).
		 */
		protected final function destroy():void
		{
			// removes the view from the display list
			if(_view.parent.contains(_view))
				_view.parent.removeChild(_view)
			// dispose the view and the controller
			_view.dispose()
			dispose()
			_view = null
			_model = null
		}
		
		public function get interests():Array { return [] }
		
		public function get name():String { return _name; }
		
		public function get parent():ViewController { return _parent }
		
		public function get children():Vector.<ViewController> { return _children }
		
		public function get autoDispose():Boolean { return _autoDispose; }
		
		public function set autoDispose(value:Boolean):void { _autoDispose = value }
		
		public function get unique():ViewController { return getController(this.name) || this; }
	}

}