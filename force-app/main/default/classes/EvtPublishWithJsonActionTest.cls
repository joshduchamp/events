@IsTest
public class EvtPublishWithJsonActionTest {
    @IsTest
    static void testPublish() {
        EvtPublishWithJsonAction.Request req = new EvtPublishWithJsonAction.Request();
        req.eventType = 'Sample';
        req.jsonStr = '{ "body": "hello world!" }';
        List<EvtPublishWithJsonAction.Request> reqList = new List<EvtPublishWithJsonAction.Request>();
        reqList.add(req);

        Test.startTest();
        EvtPublishWithJsonAction.publish(reqList);
        Test.stopTest();
    }
}
