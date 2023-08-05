public abstract class EvtAbstractHandler implements EvtHandlerInterface {
    public void execute(List<Generic_Event__e> eventList) {
        String rawMessageList = '';
        for (Generic_Event__e eventObj : eventList) {
            rawMessageList += eventObj.Data__c + ',';
        }
        rawMessageList = '[' + rawMessageList.removeEnd(',') + ']';
        List<Object> messageList = (List<Object>) JSON.deserialize(rawMessageList, getMessageType());
        handle(messageList);
    }
    protected abstract System.Type getMessageType();

    protected abstract void handle(List<Object> messageList);
}
