public class ErrorEventTriggerHandler {

    public static void afterInsert(List<ErrorEvent__e> errorEvents){
        System.debug(' ErrorEventTriggerHandler.createErrorMessage errorEvents: ' + JSON.serialize(errorEvents));

        List<ErrorMessage> errorMessages = new List<ErrorMessage>();
        for(ErrorEvent__e errorEvent: errorEvents){
            errorMessages.add(new ErrorMessage(errorEvent,'ASYNC_APEX'));
        }

        IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
        iErrorLogger.logMessages(errorMessages);
        iErrorLogger.flush();
    }

}