public abstract class EvtAbstractRecordHandler implements EvtHandlerInterface {
    public void execute(List<Generic_Event__e> eventList) {
        String rawMessageList = '';
        for (Generic_Event__e eventObj : eventList) {
            rawMessageList += eventObj.Data__c;
        }
        rawMessageList = '[' + rawMessageList.removeEnd(',') + ']';
        List<RecordInfo> infoList = (List<RecordInfo>) JSON.deserialize(rawMessageList, List<RecordInfo>.class);
        EvtRecordContext ctx = new EvtRecordContext();
        for (RecordInfo info : infoList) {
            if (info.Record != null) {
                ctx.newMap.put(info.Record.Id, info.Record);
            }
            if (info.RecordPrior != null) {
                ctx.oldMap.put(info.RecordPrior.Id, info.RecordPrior);
            }
        }
        handle(ctx);
    }

    protected abstract void handle(EvtRecordContext ctx);

    private class RecordInfo {
        public SObject Record;
        public SObject RecordPrior;
    }
}
