package pluck.core  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class ViewControllerTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:ViewController;

        [Before]
        public function setUp():void {
            instance = new ViewController(new View());
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is ViewController", instance is ViewController);
        }
		
		/**
		 *   		3
		 * 		   /
		 *        2
		 *       / \
		 *      1	4
		 * 	   / \
		 * root	  5
		 *     \
		 * 	 	6
		 * 
		 * Node 1 is removed.
		 */
		[Test]
		public function removeChildViewControllerWithSuccessors():void
		{
			const child1:ViewController = new ViewController(new View(), null, String(1))
			const child2:ViewController = new ViewController(new View(), null, String(2))
			const child3:ViewController = new ViewController(new View(), null, String(3))
			const child4:ViewController = new ViewController(new View(), null, String(4))
			const child5:ViewController = new ViewController(new View(), null, String(5))
			const child6:ViewController = new ViewController(new View(), null, String(6))
			
			// create the tree
			instance.addChildViewController(child1)
			instance.addChildViewController(child6)
			child1.addChildViewController(child2)
			child1.addChildViewController(child5)
			child2.addChildViewController(child3)
			child2.addChildViewController(child4)
			
			instance.removeChildViewController(child1)
			assertTrue('root node has got only one child: child6', instance.children.length == 1)
			assertEquals(instance.children[0], child6)
			assertTrue('child1 has not got any children', child1.children.length == 0)
			assertTrue('child2 has not got any children', child2.children.length == 0)
			assertTrue('child3 has not got any children', child3.children.length == 0)
			assertTrue('child4 has not got any children', child4.children.length == 0)
			assertTrue('child5 has not got any children', child5.children.length == 0)
		}
		
		[Test]
		public function removeChildViewController():void
		{
			const child:ViewController = new ViewController(new View(), null, 'child')
			instance.addChildViewController(child)
			instance.removeChildViewController(child)
			assertTrue('root node has not got any children', instance.children.length == 0)
			assertEquals(child.parent, null)
		}
		
		[Test]
		public function addChildViewController():void
		{
			const child:ViewController = new ViewController(new View(), null, 'child')
			instance.addChildViewController(child)
			assertTrue('root node has one child', instance.children.length == 1)
			assertEquals(child.parent, instance)
		}
		
		[Test]
		public function notificationHandling():void
		{
			const recipient:TestNotificationsViewController = new TestNotificationsViewController()
			instance.addChildViewController(recipient)
			assertFalse('notification is not accepted yet', recipient.model.notificationAccepted)
			instance.sendNotification(TestNotificationsViewController.NOTIFICATION_TYPE)
			assertTrue('notification is received successfully', recipient.model.notificationAccepted)
		}
		
		[Test]
		public function sendNoneExistingNotification():void
		{
			try {
				instance.sendNotification('noneExisting')
			}
			catch (error:Error) {
				throw new Error('Sending none existing notification throws an error!')
			}
		}
    }
}

