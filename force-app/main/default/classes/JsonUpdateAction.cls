public class JsonUpdateAction {
    @InvocableMethod(
        label='JSON Update Action'
        description='Add or update a value in a JSON object. Returns JSON as text.'
    )
    public static List<Response> updateJson(List<Request> requestList) {
        List<Response> responseList = new List<Response>();
        for (Request req : requestList) {
            Map<String, Object> jsonMap = new Map<String, Object>();
            System.debug('"' + req.jsonString + '"');
            if (req.jsonString != null && !req.jsonString.isWhitespace()) {
                jsonMap = (Map<String, Object>) JSON.deserializeUntyped(req.jsonString);
            }
            String valueType;
            if (req.type != null) {
                valueType = req.Type;
            } else if (req.value == null) {
                valueType = 'String';
            } else if (req.value.isNumeric()) {
                valueType = 'Number';
            } else if (req.value.equalsIgnoreCase('true') || req.value.equalsIgnoreCase('false')) {
                valueType = 'Boolean';
            } else {
                valueType = 'String';
            }
            if (valueType.equalsIgnoreCase('String')) {
                jsonMap.put(req.field, req.value);
            } else if (valueType.equalsIgnoreCase('Number')) {
                jsonMap.put(req.field, Decimal.valueOf(req.value));
            } else if (valueType.equalsIgnoreCase('Boolean')) {
                jsonMap.put(req.field, Boolean.valueOf(req.value));
            }
            Response res = new Response();
            res.jsonString = JSON.serializePretty(jsonMap);
            responseList.add(res);
        }
        return responseList;
    }

    public class Request {
        @InvocableVariable(label='JSON' description='JSON to be updated' required=false)
        public String jsonString;

        @InvocableVariable(
            label='Field'
            description='Field to be updated. Does not support nested fields.'
            required=true
        )
        public String field;

        @InvocableVariable(label='Value' description='The value to set' required=false)
        public String value;

        @InvocableVariable(
            label='Type'
            description='Value type: String, Number, Boolean. Leave blank to let flow decide based on value.'
            required=false
        )
        public String type;

        public Request() {
        }
        public Request(String jsonString, String field, String value, String type) {
            this.jsonString = jsonString;
            this.field = field;
            this.value = value;
            this.type = type;
        }
    }

    public class Response {
        @InvocableVariable(label='JSON' description='JSON output as text' required=true)
        public String jsonString;
    }

    public class JsonUpdateActionException extends Exception {
    }
}
