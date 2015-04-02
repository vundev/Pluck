package pluck.core  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class RootModelTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:RootModel;

        [Before]
        public function setUp():void {
            instance = new RootModel();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is RootModel", instance is RootModel);
        }
		
		[Test]
		public function testGoToPage():void
		{
			assertTrue('redirects successfully to home page', instance.goToPage('home'))
			assertEquals(instance.currentPage, 'home')
			assertFalse('you are already at home page', instance.goToPage('home'))
			assertTrue('opens home page with params', instance.goToPage('home', { id:1 } ))
			assertEquals(instance.currentParameters.id, 1)
			assertTrue('change home page params', instance.goToPage('home', { id:2 } ))
			assertEquals(instance.currentParameters.id, 2)
			assertFalse('you are already at home page', instance.goToPage('home', { id:2 } ))
			assertTrue('redirects successfully to section page', instance.goToPage('section'))
		}
    }
}

