public class BatchApexErrorEventTriggerHandler {

    public static void afterInsert(List<BatchApexErrorEvent> batchApexErrorEvents) {
        System.debug(' LogMessageBatchApexErrorHandler.afterInsertLogError batchApexErrorEvents: ' + JSON.serialize(batchApexErrorEvents));
        
        List<ErrorMessage> errorMessages = new List<ErrorMessage>();
        for (BatchApexErrorEvent batchApexErrorEvent : batchApexErrorEvents) {
            errorMessages.add(new ErrorMessage(batchApexErrorEvent.AsyncApexJobId, batchApexErrorEvent,'BATCH_APEX'));
        }

        IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
        iErrorLogger.logMessages(errorMessages);
        iErrorLogger.flush();
    }

}