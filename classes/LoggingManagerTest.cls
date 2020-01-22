/**
 * Created by user on 6/22/2017.
 */

@IsTest
private class LoggingManagerTest {

    @testSetup
    static void setup() {
        SystemSettings__c setting = new SystemSettings__c();
        setting.name = 'default';
        setting.LoggingMgrEnabled__c = true;
        setting.CheckptMgrEnabled__c = true;
        setting.CheckptMgrRemainingSOQLThresholdPct__c = 6;
        setting.CheckptMgrRemainingQueryRowsThresholdPct__c = 6;
        setting.CheckptMgrRemainingCPUThresholdPct__c = 6;
        upsert setting;
    }


    @isTest
    static void testBehaviorLogMessage() {
        SystemSettings__c setting = SystemSettings__c.getInstance('default');
        Test.startTest();
        Log logObject=new Log();
        ICheckpointManager checkpointManager=ServiceFactory.getInstance().getCheckpointManagerInstance();
        LoggingManager loggingManager = new LoggingManager();
        checkpointManager.checkpoint('Log cpm 1');
        logObject.errorMessage='Some error message';
        loggingManager.logMessage(logObject);
        
        checkpointManager.checkpoint('Log cpm 2');
        
        try{
            Integer exceptionNumber = 1/0;
        }catch(Exception e){
            ILoggingManager iloggingManager = ServiceFactory.getInstance().getLoggingManagerInstance();
            iloggingManager.logMessage(Log.ProcessType.Warning,e);
            iloggingManager.logMessage(Log.ProcessType.Warning,e,'Apex',e.getStackTraceString());
            iloggingManager.logMessage(Log.ProcessType.Warning,e,e.getMessage());
            iloggingManager.logMessage(Log.ProcessType.Warning,e,e.getMessage(),'Apex',e.getStackTraceString());
            iloggingManager.logMessage(Log.ProcessType.Warning,e,e.getMessage(),JSON.serialize('Test'));
            iloggingManager.logMessage(Log.ProcessType.Warning,e,e.getMessage(),JSON.serialize('Test'),'Apex',e.getStackTraceString());
            iloggingManager.logMessage(Log.ProcessType.Warning,e,e.getMessage(), new CustomClass());
            iloggingManager.logMessage(Log.ProcessType.Warning,e,e.getMessage(), new CustomClass(),'Apex',e.getStackTraceString());
            iloggingManager.logMessage(Log.ProcessType.Warning,e,e.getMessage(),new List<String>{'Test'});
            iloggingManager.logMessage(Log.ProcessType.Warning,e,e.getMessage(),new List<String>{'Test'},'Apex',e.getStackTraceString());
        }
        
        Test.stopTest();
        
        List<Log__c> logs=[select ErrorMessage__c,TrackingHistory__c,User__c from Log__c];
        System.assertEquals(12, logs.size());
    }

    @isTest
    public static void testInvocableLogMessage(){
        Test.startTest();

        List<LoggingManager.LogRequest> loggingManagerLogRequest = new List<LoggingManager.LogRequest>();
        LoggingManager.LogRequest logRequest = new LoggingManager.LogRequest();
        logRequest.payload = 'Test';
        logRequest.errorMessage = 'Test';
        logRequest.processType = 'ActiveDisclosureFacade';
        loggingManagerLogRequest.add(logRequest);
        LoggingManager.invocableLogMessage(loggingManagerLogRequest);

        Test.stopTest();
        List<Log__c> logs=[select ErrorMessage__c,TrackingHistory__c,User__c from Log__c];
        System.assertEquals(1,logs.size());
    }
        
    public class CustomClass{}
}