@IsTest
public class EvtTest {
    @IsTest
    static void testPublishRecordInfo() {
        Contact record = new Contact();
        Contact recordPrior = new Contact();
        Evt.publish('test', record, recordPrior);
    }

    @IsTest
    static void testPublishObject() {
        TestObject obj = new TestObject();
        obj.thing1 = 'hello';
        Evt.publish('test', obj);
    }

    private class TestObject {
        public String thing1;
    }
}
