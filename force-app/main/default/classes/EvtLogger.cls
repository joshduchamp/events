public virtual class EvtLogger {
    protected List<EvtLog__c> logList = new List<EvtLog__c>();
    protected EvtLog__c currentLog {
        get {
            return logList.isEmpty() ? null : logList[logList.size() - 1];
        }
    }

    // builds a new EvtLog__c and adds to list
    public virtual void buildLog(List<Generic_Event__e> eventList) {
        EvtLog__c evtLog = new EvtLog__c();
        if (!eventList.isEmpty()) {
            evtLog.Type__c = eventList[0].Type__c;
            evtLog.Status__c = 'Success';
            evtLog.Data__c = getData(eventList);
        }
        logList.add(evtLog);
    }

    // adds exception info to current log
    public virtual void addException(Exception ex) {
        currentLog.Status__c = 'Error';
        currentLog.Error_Message__c = ex.getMessage();
        currentLog.Stack_Trace__c = ex.getStackTraceString();
    }

    // saves all logs to database
    public virtual void saveLogs() {
        if (!logList.isEmpty()) {
            insert logList;
        }
    }

    private static String getData(List<Generic_Event__e> eventList) {
        String data = '';
        for (Generic_Event__e evt : eventList) {
            data += evt.Data__c + ',';
        }
        data = data.removeEnd(',');
        if (eventList.size() > 1) {
            data = '[' + data + ']';
        }
        return data;
    }
}
