public class BatchApexErrorEventTriggerHandler {

    public static void afterInsert(List<BatchApexErrorEvent> batchApexErrorEvents) {
        System.debug(' LogMessageBatchApexErrorHandler.afterInsertLogError batchApexErrorEvents: ' + JSON.serialize(batchApexErrorEvents));
        
        List<ErrorMessage> errorMessages = new List<ErrorMessage>();
        for (BatchApexErrorEvent evt : batchApexErrorEvents) {
            errorMessages.add(new ErrorMessage(evt.AsyncApexJobId, evt));
        }

        IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
        iErrorLogger.logMessages(errorMessages);
        iErrorLogger.flush();
    }

}