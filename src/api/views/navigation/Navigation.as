package api.views.navigation 
{
	import pluck.core.View;
	
	/**
	 * ...
	 * @author Atanas Vasilev at avant.vasilev@gmail.com
	 */
	public class Navigation extends View
	{
		
		public function Navigation(numberOfScreens:uint) 
		{
			var prevItem:NavigationItem
			for (var i:int = 0; i < numberOfScreens; i++) 
			{
				var item:NavigationItem = new NavigationItem(String(i))
				addChild(item)
				item.x = (prevItem ? prevItem.x + prevItem.width : 0) + item.width
				prevItem = item
				addChild(item)
			}
		}
		
	}

}