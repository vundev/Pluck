package pluck.utils  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class ExternalTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        [Before]
        public function setUp():void {
           
        }

        [After]
        public function tearDown():void {
            
        }

		[Test]
		public function testSerialization():void
		{
			const message:Object = {
				command:'command',
				complex: {
					subCommand:'subCommand',
					subComplex: {
						data:[1, 2]
					}
				},
				skipped:'skipped'
			};
			const serializedMessage:Message = new Message();
			serializedMessage.serialize(message);

			assertEquals(serializedMessage.command, message.command);
			assertEquals(serializedMessage.complex.subCommand, message.complex.subCommand)
			assertEqualsArrays(serializedMessage.complex.subComplex.data, message.complex.subComplex.data)
			assertEquals(serializedMessage.doesNotParticipate, 'doesNotParticipate')
		}
    }
}

