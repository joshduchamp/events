@IsTest
public class EvtFlowRunnerTest {
    @IsTest
    static void testRun() {
        Test.startTest();
        EvtRunnerContext ctx = new EvtRunnerContext();
        ctx.handlerApiName = 'EvtSampleFlowHandler';
        ctx.eventList = new List<Generic_Event__e>();
        ctx.eventList.add(new Generic_Event__e(Data__c = '{ "body": "hello world!" }'));
        EvtFlowRunner runner = new EvtFlowRunner();
        runner.run(ctx);
        Test.stopTest();
    }
}
