public without sharing class EvtDispatcher {
    private final EvtLogger logger;

    public EvtDispatcher(EvtLogger logger) {
        this.logger = logger;
    }

    public void dispatchEvents(List<Generic_Event__e> eventList) {
        Map<String, List<Generic_Event__e>> eventMap = groupEventsByType(eventList);
        for (String eventType : eventMap.keySet()) {
            dispatchByType(eventType, eventMap.get(eventType));
        }
        logger.saveLogs();
    }

    private void dispatchByType(String eventType, List<Generic_Event__e> eventList) {
        try {
            logger.buildLog(eventList);
            Event_Handler_Route__mdt route = Event_Handler_Route__mdt.getInstance(eventType);
            if (route != null) {
                if (route.Active__c) {
                    invokeRunner(route, eventList);
                } else {
                    throw new EvtException('Route inactive for event type "' + eventType + '"');
                }
            } else {
                throw new EvtException('Route not found for event type "' + eventType + '"');
            }
        } catch (Exception ex) {
            logger.addException(ex);
        }
    }

    private static void invokeRunner(Event_Handler_Route__mdt route, List<Generic_Event__e> eventList) {
        System.Type runnerType = Type.forName(route.EvtRunner__c);
        EvtRunner runner = (EvtRunner) runnerType.newInstance();
        EvtRunnerContext ctx = new EvtRunnerContext();
        ctx.handlerApiName = route.Handler_Api_Name__c;
        ctx.eventList = eventList;
        runner.run(ctx);
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
}
