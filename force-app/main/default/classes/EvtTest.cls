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

    @IsTest
    static void testPublishAll() {
        List<TestObject> objList = new List<TestObject>();
        for (Integer i = 0; i < 100; i++) {
            TestObject obj = new TestObject();
            obj.thing1 = String.valueOf(i);
            objList.add(obj);
        }
        Evt.publishAll('test', objList);
    }

    private class TestObject {
        public String thing1;
    }
}
