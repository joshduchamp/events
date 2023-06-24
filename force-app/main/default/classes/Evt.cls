global class Evt {
    global static void publish(String eventType, Object message) {
        EventBus.publish(new Generic_Event__e(Type__c = eventType, Data__c = JSON.serialize(message)));
    }

    global static void publish(String eventType, SObject record, SObject recordPrior) {
        EvtRecordInfo info = new EvtRecordInfo();
        info.Record = record;
        info.RecordPrior = recordPrior;
        publish(eventType, info);
    }
}
