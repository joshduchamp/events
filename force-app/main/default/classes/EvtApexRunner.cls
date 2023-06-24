public class EvtApexRunner implements EvtRunner {
    public void run(EvtRunnerContext ctx) {
        System.Type handlerClassType = Type.forName(ctx.handlerApiName);
        EvtHandlerInterface handler = (EvtHandlerInterface) handlerClassType.newInstance();
        handler.execute(ctx.eventList);
    }
}
