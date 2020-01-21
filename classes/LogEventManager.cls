public class LogEventManager {
    public static void raiseEvent(String errorMessage, String processType, String source){
        LoggingEvent__e loggingEvent = new LoggingEvent__e();
        loggingEvent.Error_Message__c = errorMessage;
        loggingEvent.ProcessType__c = processType;
        loggingEvent.Source__c = source;
        EventBus.publish(loggingEvent);
    }
}