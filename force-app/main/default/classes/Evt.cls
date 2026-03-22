global class Evt {
    global static void publish(String eventType, Object message) {
        publishAll(eventType, new List<Object>{ message });
    }

    global static void publish(String eventType, SObject record, SObject recordPrior) {
        List<SObject> recordList = new List<SObject>{ record };
        List<SObject> recordPriorList = recordPrior == null ? null : new List<SObject>{ recordPrior };
        publishAll(eventType, recordList, recordPriorList);
    }

    global static void publishAll(String eventType, List<Object> messageList) {
        List<Generic_Event__e> eventList = new List<Generic_Event__e>();
        for (Object message : messageList) {
            eventList.add(new Generic_Event__e(Type__c = eventType, Data__c = JSON.serialize(message)));
        }
        EventBus.publish(eventList);
        try {
            EvtLogger.logEventActivity('Pub', JSON.serialize(eventList));
        } catch (Exception e) {
            System.debug('error creating platform event log activity:' + e.getMessage());
            //throw new EvtLoggerException(e.getMessage());  //uncomment this line to cause failures to log to be rolled back
        }
    }

    global static void publishAll(String eventType, List<SObject> recordList, List<SObject> recordPriorList) {
        List<EvtRecordInfo> infoList = new List<EvtRecordInfo>();
        for (Integer i = 0; i < recordList.size(); i++) {
            EvtRecordInfo info = new EvtRecordInfo();
            info.Record = recordList[i];
            if (recordPriorList != null && recordPriorList.size() > 0) {
                info.RecordPrior = recordPriorList.remove(0);
            }
            infoList.add(info);
        }
        publishAll(eventType, infoList);
    }
}
