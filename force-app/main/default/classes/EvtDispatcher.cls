public without sharing class EvtDispatcher {
    private final EvtLogger logger;

    public EvtDispatcher(EvtLogger logger) {
        this.logger = logger;
    }

    public void dispatchEvents(List<Generic_Event__e> eventList) {
        Map<String, List<Generic_Event__e>> eventMap = groupEventsByType(eventList);
        for (String eventType : eventMap.keySet()) {
            try {
                List<Generic_Event__e> myEventList = eventMap.get(eventType);
                logger.buildLog(myEventList);
                Event_Handler_Route__mdt route = Event_Handler_Route__mdt.getInstance(eventType);
                if (route != null) {
                    if (route.Active__c) {
                        if (route.Handler_Type__c == 'Apex') {
                            System.Type handlerClassType = Type.forName(route.Handler_Api_Name__c);
                            EvtHandlerInterface handler = (EvtHandlerInterface) handlerClassType.newInstance();
                            handler.execute(myEventList);
                        } else if (route.Handler_Type__c == 'Flow') {
                            for (Generic_Event__e eventObj : myEventList) {
                                Map<String, Object> inputVariables = (Map<String, Object>) JSON.deserializeUntyped(
                                    eventObj.Data__c
                                );
                                Flow.Interview flowInterview = Flow.Interview.createInterview(
                                    route.Handler_Api_Name__c,
                                    inputVariables
                                );
                                flowInterview.start();
                            }
                        } else {
                            throw new EvtDispatchException('Invalid handler type: ' + route.Handler_Type__c);
                        }
                    } else {
                        throw new EvtDispatchException('Route inactive for event type "' + eventType + '"');
                    }
                } else {
                    throw new EvtDispatchException('Route not found for event type "' + eventType + '"');
                }
            } catch (Exception ex) {
                logger.addException(ex);
            }
        }
        logger.saveLogs();
    }

    private static Map<String, List<Generic_Event__e>> groupEventsByType(List<Generic_Event__e> eventList) {
        Map<String, List<Generic_Event__e>> eventMap = new Map<String, List<Generic_Event__e>>();
        for (Generic_Event__e eventObj : eventList) {
            List<Generic_Event__e> evtList = eventMap.get(eventObj.Type__c);
            if (evtList == null) {
                evtList = new List<Generic_Event__e>();
                eventMap.put(eventObj.Type__c, evtList);
            }
            evtList.add(eventObj);
        }
        return eventMap;
    }

    public class EvtDispatchException extends Exception {
    }
}
