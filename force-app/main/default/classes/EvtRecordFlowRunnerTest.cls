@IsTest
public class EvtRecordFlowRunnerTest {
    @IsTest
    static void testRun() {
        Contact record = new Contact(FirstName = 'Bruce', LastName = 'Lee');
        Contact recordPrior = new Contact(FirstName = 'Bruce', LastName = 'Wayne');
        Map<String, SObject> data = new Map<String, SObject>();
        data.put('Record', record);
        data.put('RecordPrior', recordPrior);
        String jsonStr = JSON.serializePretty(data);

        Test.startTest();
        EvtRunnerContext ctx = new EvtRunnerContext();
        ctx.handlerApiName = 'EvtSampleRecordFlowHandler';
        ctx.eventList = new List<Generic_Event__e>();
        ctx.eventList.add(new Generic_Event__e(Data__c = jsonStr));
        EvtRecordFlowRunner runner = new EvtRecordFlowRunner();
        runner.run(ctx);
        Test.stopTest();
    }
}
