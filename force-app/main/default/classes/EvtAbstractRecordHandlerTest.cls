@IsTest
public class EvtAbstractRecordHandlerTest {
    @IsTest
    static void testExecute() {
        Test.startTest();
        Map<String, SObject> data = new Map<String, SObject>();
        data.put('Record', new Contact(Id = '003DR00000o1SAGYA2'));
        data.put('RecordPrior', new Contact(Id = '003DR00000o1SAGYA2'));
        List<Generic_Event__e> eventList = new List<Generic_Event__e>{
            new Generic_Event__e(Type__c = 'Test', Data__c = JSON.serialize(data))
        };
        TestHandler handler = new TestHandler();
        handler.execute(eventList);
        Test.stopTest();

        Assert.isTrue(didRun);
    }

    private static Boolean didRun = false;

    private class TestHandler extends EvtAbstractRecordHandler {
        protected override void handle(EvtRecordContext ctx) {
            didRun = true;
        }
    }
}
