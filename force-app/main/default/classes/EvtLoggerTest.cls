@IsTest
public class EvtLoggerTest {
    @IsTest
    static void testSuccessLog() {
        List<Generic_Event__e> eventList = new List<Generic_Event__e>{
            new Generic_Event__e(Type__c = 'Test', Data__c = '{"body":"hello world!"}')
        };

        Test.startTest();
        EvtLogger logger = new EvtLogger();
        logger.buildLog(eventList);
        logger.saveLogs();
        Test.stopTest();

        List<EvtLog__c> logList = [SELECT Id, Status__c FROM EvtLog__c];
        Assert.areEqual(1, logList.size());
        Assert.areEqual('Success', logList[0].Status__c);
    }

    @IsTest
    static void testErrorLog() {
        List<Generic_Event__e> eventList = new List<Generic_Event__e>{
            new Generic_Event__e(Type__c = 'Test', Data__c = '{"body":"hello world!"}')
        };

        Test.startTest();
        EvtLogger logger = new EvtLogger();
        logger.buildLog(eventList);
        try {
            throw new TestException();
        } catch (TestException ex) {
            logger.addException(ex);
        }
        logger.saveLogs();
        Test.stopTest();

        List<EvtLog__c> logList = [SELECT Id, Status__c FROM EvtLog__c];
        Assert.areEqual(1, logList.size());
        Assert.areEqual('Error', logList[0].Status__c);
    }

    private class TestException extends Exception {
    }
}
