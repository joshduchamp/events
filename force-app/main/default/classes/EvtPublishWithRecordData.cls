public with sharing class EvtPublishWithRecordData {
    @InvocableMethod(label='Publish Event with Record Data')
    public static void publish(List<Request> requestList) {
        List<Generic_Event__e> eventList = new List<Generic_Event__e>();
        for (Request req : requestList) {
            Map<String, SObject> mapSObject = new Map<String, SObject>();
            mapSObject.put('Record', req.record);
            mapSObject.put('RecordPrior', req.recordPrior);
            String jsonStr = JSON.serializePretty(mapSObject);
            Generic_Event__e evt = new Generic_Event__e(Type__c = req.eventType, Data__c = jsonStr);
            eventList.add(evt);
        }
        EventBus.publish(eventList);
    }

    public class Request {
        @InvocableVariable(label='Event Type' description='The type of event to publish' required=true)
        public String eventType;

        @InvocableVariable(label='Record' description='use {!$Record}' required=true)
        public SObject record;

        @InvocableVariable(label='RecordPrior' description='use {!$Record__Prior}' required=true)
        public SObject recordPrior;
    }
}
