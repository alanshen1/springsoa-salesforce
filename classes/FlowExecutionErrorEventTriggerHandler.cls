public class FlowExecutionErrorEventTriggerHandler {

    public static void afterInsert(List<FlowExecutionErrorEvent> flowExecutionErrorEvents) {
        System.debug(' LogMessageFlowExecutionErrorHandler.afterInsert flowExecutionErrorEvents: ' + JSON.serialize(flowExecutionErrorEvents));

        List<ErrorMessage> errorMessages = new List<ErrorMessage>();
        for (FlowExecutionErrorEvent evt : flowExecutionErrorEvents) {
            errorMessages.add(new ErrorMessage(evt.FlowApiName, evt));
        }

        IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
        iErrorLogger.logMessages(errorMessages);
        iErrorLogger.flush();
    }
}