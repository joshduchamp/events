public without sharing class EvtSampleHandler extends EvtAbstractHandler {
    protected override System.Type getMessageType() {
        return List<SampleMessage>.class;
    }

    protected override void handle(List<Object> messageList) {
        for (SampleMessage msg : (List<SampleMessage>) messageList) {
            System.debug(msg.body);
        }
    }

    public class SampleMessage {
        public String body { get; set; }
    }
}
