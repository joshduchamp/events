@IsTest
public class EvtPublishWithKVPActionTest {
    @IsTest
    static void testPublish() {
        EvtPublishWithKVPAction.Request req = new EvtPublishWithKVPAction.Request();
        req.eventType = 'Test';
        req.x1Key = 'stringValue';
        req.x1Value = 'hello world!';
        req.x2Key = 'numberValue';
        req.x2Value = '42';
        req.x3Key = 'booleanValue';
        req.x3Value = 'true';
        req.x4Key = 'nullValue';
        req.x4Value = null;
        List<EvtPublishWithKVPAction.Request> requestList = new List<EvtPublishWithKVPAction.Request>();
        requestList.add(req);

        Test.startTest();
        EvtPublishWithKVPAction.publish(requestList);
        Test.stopTest();
    }
}
