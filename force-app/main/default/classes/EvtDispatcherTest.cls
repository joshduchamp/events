@IsTest
public class EvtDispatcherTest {
    @IsTest
    static void dispatchApexEvent() {
        EvtSampleHandler.SampleMessage msg = new EvtSampleHandler.SampleMessage();
        msg.body = 'Hello world!';
        List<Generic_Event__e> eventList = new List<Generic_Event__e>();
        eventList.add(new Generic_Event__e(Type__c = 'SampleApex', Data__c = JSON.serialize(msg)));

        Test.startTest();
        TestLogger logger = new TestLogger();
        EvtDispatcher dispatcher = new EvtDispatcher(logger);
        dispatcher.dispatchEvents(eventList);
        Test.stopTest();

        Assert.areEqual(1, logger.savedLogs.size(), 'EvtLog not created');
        Assert.areEqual(
            'Success',
            logger.savedLogs[0].Status__c,
            logger.savedLogs[0].Error_Message__c + ' ' + logger.savedLogs[0].Stack_Trace__c
        );
    }

    @IsTest
    static void dispatchFlowEvent() {
        EvtSampleHandler.SampleMessage msg = new EvtSampleHandler.SampleMessage();
        msg.body = 'Hello world!';
        List<Generic_Event__e> eventList = new List<Generic_Event__e>();
        eventList.add(new Generic_Event__e(Type__c = 'SampleFlow', Data__c = JSON.serialize(msg)));

        Test.startTest();
        TestLogger logger = new TestLogger();
        EvtDispatcher dispatcher = new EvtDispatcher(logger);
        dispatcher.dispatchEvents(eventList);
        Test.stopTest();

        Assert.areEqual(1, logger.savedLogs.size(), 'EvtLog not created');
        Assert.areEqual(
            'Success',
            logger.savedLogs[0].Status__c,
            logger.savedLogs[0].Error_Message__c + ' ' + logger.savedLogs[0].Stack_Trace__c
        );
    }

    private class TestLogger extends EvtLogger {
        public List<EvtLog__c> savedLogs = new List<EvtLog__c>();

        public override void saveLogs() {
            savedLogs.addAll(this.logList);
        }
    }
}
