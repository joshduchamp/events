trigger EvtTrigger on Generic_Event__e(after insert) {
    EvtDispatcher.dispatchEvents((List<Generic_Event__e>) Trigger.New);
}
