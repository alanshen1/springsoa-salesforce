public class LogMessageBatchApexErrorHandler {
    public static void createErrorMessage(List<BatchApexErrorEvent> batchApexErrorEvents){
        System.debug('LogMessageBatchApexErrorHandler.createErrorMessage batchApexErrorEvents: ' + JSON.serialize(batchApexErrorEvents));
        List<ErrorMessage> errorMessages = new List<ErrorMessage>();
        for(BatchApexErrorEvent evt: batchApexErrorEvents){
            errorMessages.add(new ErrorMessage(evt.AsyncApexJobId,evt));
        }
        IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
        iErrorLogger.logMessages(errorMessages);
        iErrorLogger.flush();
    }
}