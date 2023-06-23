@IsTest
public class EvtDispatcherTest {
    @IsTest
    static void dispatchApexEvent() {
        EvtSampleHandler.SampleMessage msg = new EvtSampleHandler.SampleMessage();
        msg.body = 'Hello world!';
        List<Generic_Event__e> eventList = new List<Generic_Event__e>();
        eventList.add(new Generic_Event__e(Type__c = 'SampleApex', Data__c = JSON.serialize(msg)));

        Test.startTest();
        EvtDispatcher.dispatchEvents(eventList);
        Test.stopTest();

        List<EvtLog__c> evtLogList = [SELECT Id, Status__c FROM EvtLog__c];
        Assert.areEqual(1, evtLogList.size(), 'EvtLog not created');
        Assert.areEqual('Success', evtLogList[0].Status__c);
    }

    @IsTest
    static void dispatchFlowEvent() {
        EvtSampleHandler.SampleMessage msg = new EvtSampleHandler.SampleMessage();
        msg.body = 'Hello world!';
        List<Generic_Event__e> eventList = new List<Generic_Event__e>();
        eventList.add(new Generic_Event__e(Type__c = 'SampleFlow', Data__c = JSON.serialize(msg)));

        Test.startTest();
        EvtDispatcher.dispatchEvents(eventList);
        Test.stopTest();

        List<EvtLog__c> evtLogList = [SELECT Id, Status__c FROM EvtLog__c];
        Assert.areEqual(1, evtLogList.size(), 'EvtLog not created');
        Assert.areEqual('Success', evtLogList[0].Status__c);
    }
}
