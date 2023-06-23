@IsTest
public class EvtTriggerTest {
    @IsTest
    static void runTrigger() {
        Test.startTest();
        EventBus.publish(new Generic_Event__e(Type__c = 'Test'));
        Test.stopTest();
    }
}
