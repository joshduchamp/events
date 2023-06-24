trigger EvtTrigger on Generic_Event__e(after insert) {
    EvtLogger logger = new EvtLogger();
    EvtDispatcher dispatcher = new EvtDispatcher(logger);
    dispatcher.dispatchEvents((List<Generic_Event__e>) Trigger.new);
}
