public class EvtFlowRunner implements EvtRunner {
    public void run(EvtRunnerContext ctx) {
        for (Generic_Event__e eventObj : ctx.eventList) {
            Map<String, Object> inputVariables = (Map<String, Object>) JSON.deserializeUntyped(eventObj.Data__c);
            Flow.Interview flowInterview = Flow.Interview.createInterview(ctx.handlerApiName, inputVariables);
            flowInterview.start();
        }
    }
}
