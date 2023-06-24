public with sharing class EvtPublishWithJsonAction {
    @InvocableMethod(label='Publish Event with JSON' description='Publish an event with JSON data')
    public static void publish(List<Request> requestList) {
        List<Generic_Event__e> eventList = new List<Generic_Event__e>();
        for (Request req : requestList) {
            Generic_Event__e evt = new Generic_Event__e(Type__c = req.eventType, Data__c = req.jsonStr);
            eventList.add(evt);
        }
        EventBus.publish(eventList);
    }

    public class Request {
        @InvocableVariable(label='Event Type' description='The type of event to publish' required=true)
        public String eventType;

        @InvocableVariable(label='JSON' description='The JSON message to publish' required=true)
        public String jsonStr;
    }
}
