package pluck.display  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class PLTextFieldTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:PLTextField;

        [Before]
        public function setUp():void {
            instance = new PLTextField();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is PLTextField", instance is PLTextField);
        }
		
		[Test]
		public function testTranslations():void
		{
			var data:XML = < data > < multilingual > < text lang = "en" > English </text><text lang="bg">Английски</text ></multilingual></data>
			assertEquals(PLTextField.translate(data.multilingual.text, 'en'), 'English');
			assertEquals(PLTextField.translate(data.multilingual.text, 'bg'), 'Английски');
			assertEquals(PLTextField.translate(data.multilingual.text, 'ru'), 'not translated')
		}
    }
}

