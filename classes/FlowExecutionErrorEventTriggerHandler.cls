public class FlowExecutionErrorEventTriggerHandler {

    public static void afterInsert(List<FlowExecutionErrorEvent> flowExecutionErrorEvents) {
        System.debug(' LogMessageFlowExecutionErrorHandler.afterInsert flowExecutionErrorEvents: ' + JSON.serialize(flowExecutionErrorEvents));

        List<ErrorMessage> errorMessages = new List<ErrorMessage>();
        for (FlowExecutionErrorEvent flowExecutionErrorEvent : flowExecutionErrorEvents) {
            errorMessages.add(new ErrorMessage(flowExecutionErrorEvent.FlowApiName, flowExecutionErrorEvent));
        }

        IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
        iErrorLogger.logMessages(errorMessages);
        iErrorLogger.flush();
    }
    
}