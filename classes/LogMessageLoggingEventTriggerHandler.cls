public class LogMessageLoggingEventTriggerHandler {
    public static void createErrorMessage(List<LoggingEvent__e> loggingEvents){
        System.debug('LoggingEventTriggerHandler.createErrorMessage loggingEvents: ' + JSON.serialize(loggingEvents));
        List<ErrorMessage> errorMessages = new List<ErrorMessage>();
        for(LoggingEvent__e evt: loggingEvents){
            errorMessages.add(new ErrorMessage(evt));
        }
        IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
        iErrorLogger.logMessages(errorMessages);
        iErrorLogger.flush();
    }
}