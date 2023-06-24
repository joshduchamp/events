@IsTest
public class EvtApexRunnerTest {
    @IsTest
    static void testRun() {
        Test.startTest();
        EvtRunnerContext ctx = new EvtRunnerContext();
        ctx.handlerApiName = 'EvtApexRunnerTest.TestHandler';
        EvtApexRunner runner = new EvtApexRunner();
        runner.run(ctx);
        Test.stopTest();

        Assert.isTrue(didRun);
    }

    public static Boolean didRun = false;
    public class TestHandler implements EvtHandlerInterface {
        public void execute(List<Generic_Event__e> eventList) {
            didRun = true;
        }
    }
}
