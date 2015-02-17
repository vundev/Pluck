package api.controllers 
{
	import api.models.ColorPickerModel;
	import api.views.color_picker.ColorPicker;
	import flash.events.MouseEvent;
	import pluck.core.ViewController;
	import com.greensock.TweenMax
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class ColorPickerController extends ViewController
	{
		public static const CHANGE_COLOR:String = 'changeColor';
		
		public function ColorPickerController() 
		{
			autoDispose = false
		}
		
		override public function onRegister():void 
		{
			_model = new ColorPickerModel()
			_view = new ColorPicker(_model.objectID)
			
			_view.y = 100;
			_view.x = -88;
			TweenMax.to(_view, 1, { x:0, delay:1 } )
			_view.addEventListener(MouseEvent.CLICK, onChangeColor)
		}
		
		override public function onUnregister():void 
		{
			super.onUnregister();
			TweenMax.to(_view, 1, { x:-88, onComplete:this.destroy, overwrite:1 } )
		}
		
		private function onChangeColor(event:MouseEvent):void
		{
			sendNotification(CHANGE_COLOR, { color:0xffffff * Math.random() } )
		}
		
		override public function dispose():void 
		{
			super.dispose();
			_view.removeEventListener(MouseEvent.CLICK, onChangeColor)
			TweenMax.killTweensOf(_view)
		}
		
		public function toString():String
		{
			return '[ColorPickerController id=' + model.objectID + ']';
		}
		
		public function get model():ColorPickerModel { return _model as ColorPickerModel; }
	}

}