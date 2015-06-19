package api.models 
{
	import com.greensock.loading.XMLLoader;
	import pluck.core.IDisposable;
	import pluck.core.RootModel;
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class AppModel extends RootModel implements IDisposable
	{
		public static const NAMESPACE:String = 'api::';
		public static const CONTENT_LOADER_NAME:String = NAMESPACE+'content';
		
		public var langs:Array
		public var loader:XMLLoader = new XMLLoader('../assets/content.xml', { name:AppModel.CONTENT_LOADER_NAME } )
		
		public function AppModel() 
		{
			
		}
		
		public function dispose():void
		{
			loader.dispose()
			loader = null;
		}
		
	}

}