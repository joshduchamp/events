@IsTest
public class JsonUpdateActionTest {
    @IsTest
    static void testJsonUpdateAction() {
        TestObjCls testObj = new TestObjCls();
        testObj.stringValue = 'Hello world!';
        testObj.numberValue = 42;
        testObj.booleanValue = false;
        testObj.nullValue = null;
        testObj.explicitString = 'Hello summer!';
        testObj.explicitNumber = 37;
        testObj.explicitBoolean = false;

        Test.startTest();
        String jsonStr = null;
        jsonStr = JsonUpdateAction.updateJson(
                new List<JsonUpdateAction.Request>{
                    new JsonUpdateAction.Request(jsonStr, 'stringValue', testObj.stringValue, null)
                }
            )[0]
            .jsonString;
        jsonStr = JsonUpdateAction.updateJson(
                new List<JsonUpdateAction.Request>{
                    new JsonUpdateAction.Request(jsonStr, 'numberValue', String.valueOf(testObj.numberValue), null)
                }
            )[0]
            .jsonString;
        jsonStr = JsonUpdateAction.updateJson(
                new List<JsonUpdateAction.Request>{
                    new JsonUpdateAction.Request(jsonStr, 'booleanValue', String.valueOf(testObj.booleanValue), null)
                }
            )[0]
            .jsonString;
        jsonStr = JsonUpdateAction.updateJson(
                new List<JsonUpdateAction.Request>{
                    new JsonUpdateAction.Request(jsonStr, 'nullValue', testObj.nullValue, null)
                }
            )[0]
            .jsonString;
        jsonStr = JsonUpdateAction.updateJson(
                new List<JsonUpdateAction.Request>{
                    new JsonUpdateAction.Request(jsonStr, 'explicitString', testObj.explicitString, 'String')
                }
            )[0]
            .jsonString;
        jsonStr = JsonUpdateAction.updateJson(
                new List<JsonUpdateAction.Request>{
                    new JsonUpdateAction.Request(
                        jsonStr,
                        'explicitNumber',
                        String.valueOf(testObj.explicitNumber),
                        'Number'
                    )
                }
            )[0]
            .jsonString;
        jsonStr = JsonUpdateAction.updateJson(
                new List<JsonUpdateAction.Request>{
                    new JsonUpdateAction.Request(
                        jsonStr,
                        'explicitBoolean',
                        String.valueOf(testObj.explicitBoolean),
                        'Boolean'
                    )
                }
            )[0]
            .jsonString;
        Test.stopTest();

        TestObjCls result = (TestObjCls) JSON.deserialize(jsonStr, TestObjCls.class);
        Assert.areEqual(testObj.stringValue, result.stringValue);
        Assert.areEqual(testObj.numberValue, result.numberValue);
        Assert.areEqual(testObj.booleanValue, result.booleanValue);
        Assert.areEqual(testObj.nullValue, result.nullValue);
        Assert.areEqual(testObj.explicitString, result.explicitString);
        Assert.areEqual(testObj.explicitNumber, result.explicitNumber);
        Assert.areEqual(testObj.explicitBoolean, result.explicitBoolean);
    }

    private class TestObjCls {
        public String stringValue;
        public Integer numberValue;
        public Boolean booleanValue;
        public String nullValue;
        public String explicitString;
        public Integer explicitNumber;
        public Boolean explicitBoolean;
    }
}
