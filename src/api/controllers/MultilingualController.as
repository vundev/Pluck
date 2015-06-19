package api.controllers 
{
	import api.views.multilingual.MultilingualView;
	import flash.events.MouseEvent;
	import pluck.core.ViewController;
	import com.greensock.loading.LoaderMax
	import api.models.AppModel
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class MultilingualController extends ViewController
	{
		
		public function MultilingualController() 
		{
			
		}
		
		override public function onRegister():void 
		{
			_view = new MultilingualView(LoaderMax.getContent(AppModel.CONTENT_LOADER_NAME).multilingual.text, RootController(ViewController.root).model.langs);
			view.langButtons.addEventListener(MouseEvent.CLICK, onChangeLanguage)
			checkForInitialAttrs()
		}
		
		private function onChangeLanguage(event:MouseEvent):void
		{			
			sendNotification(RootController.START_LANG_CHANGE, { lang:event.target.name } )
		}
		
		private function get view():MultilingualView { return _view as MultilingualView; }
		
		override public function dispose():void 
		{
			super.dispose();
			view.langButtons.removeEventListener(MouseEvent.CLICK, onChangeLanguage)
		}
		
	}

}