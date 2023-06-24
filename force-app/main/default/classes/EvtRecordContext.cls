public class EvtRecordContext {
    public Map<Id, SObject> oldMap = new Map<Id, SObject>();
    public Map<Id, SObject> newMap = new Map<Id, SObject>();
    public List<SObject> newList {
        get {
            return newMap.values();
        }
    }
}
