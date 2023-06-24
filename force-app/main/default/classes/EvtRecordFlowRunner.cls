public class EvtRecordFlowRunner implements EvtRunner {
    public void run(EvtRunnerContext ctx) {
        for (Generic_Event__e eventObj : ctx.eventList) {
            EvtRecordInfo info = (EvtRecordInfo) JSON.deserialize(eventObj.Data__c, EvtRecordInfo.class);
            Map<String, SObject> inputVariables = new Map<String, SObject>();
            inputVariables.put('Record', info.Record);
            inputVariables.put('RecordPrior', info.RecordPrior);
            Flow.Interview flowInterview = Flow.Interview.createInterview(ctx.handlerApiName, inputVariables);
            flowInterview.start();
        }
    }
}
