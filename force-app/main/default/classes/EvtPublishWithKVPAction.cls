public with sharing class EvtPublishWithKVPAction {
    @InvocableMethod(label='Publish Event with Key Value Pairs')
    public static void publish(List<Request> requestList) {
        List<Generic_Event__e> eventList = new List<Generic_Event__e>();
        for (Request req : requestList) {
            Boolean pretty = true;
            JSONGenerator gen = JSON.createGenerator(pretty);
            gen.writeStartObject();
            Map<String, String> kvpMap = req.getKvpMap();
            for (String key : kvpMap.keySet()) {
                String value = kvpMap.get(key);
                writeKVP(gen, key, value);
            }
            gen.writeEndObject();
            gen.close();
            String jsonStr = gen.getAsString();
            Generic_Event__e evt = new Generic_Event__e(Type__c = req.eventType, Data__c = jsonStr);
            eventList.add(evt);
        }
        EventBus.publish(eventList);
    }

    private static void writeKVP(JSONGenerator gen, String key, String value) {
        gen.writeFieldName(key);
        if (value == null) {
            gen.writeNull();
        } else if (value.isNumeric()) {
            gen.writeNumber(Decimal.valueOf(value));
        } else if (value.equalsIgnoreCase('true') || value.equalsIgnoreCase('false')) {
            gen.writeBoolean(Boolean.valueOf(value));
        } else {
            gen.writeString(value);
        }
    }

    public class Request {
        @InvocableVariable(label='Event Type' description='The type of event to publish' required=true)
        public String eventType;

        @InvocableVariable(label='1. Key')
        public String x1Key;

        @InvocableVariable(label='1. Value')
        public String x1Value;

        @InvocableVariable(label='2. Key')
        public String x2Key;

        @InvocableVariable(label='2. Value')
        public String x2Value;

        @InvocableVariable(label='3. Key')
        public String x3Key;

        @InvocableVariable(label='3. Value')
        public String x3Value;

        @InvocableVariable(label='4. Key')
        public String x4Key;

        @InvocableVariable(label='4. Value')
        public String x4Value;

        @InvocableVariable(label='5. Key')
        public String x5Key;

        @InvocableVariable(label='5. Value')
        public String x5Value;

        public Map<String, String> getKvpMap() {
            Map<String, String> kvpMap = new Map<String, String>();
            if (x1Key != null) {
                kvpMap.put(x1Key, x1Value);
            }
            if (x2Key != null) {
                kvpMap.put(x2Key, x2Value);
            }
            if (x3Key != null) {
                kvpMap.put(x3Key, x3Value);
            }
            if (x4Key != null) {
                kvpMap.put(x4Key, x4Value);
            }
            if (x5Key != null) {
                kvpMap.put(x5Key, x5Value);
            }
            return kvpMap;
        }
    }
}
