public class LogMessageFlowExecutionErrorHandler {
    public static void createErrorMessage(List<FlowExecutionErrorEvent> flowExecutionErrorEvents){
        System.debug('LogMessageFlowExecutionErrorHandler.createErrorMessage flowExecutionErrorEvents: ' + JSON.serialize(flowExecutionErrorEvents));
        List<ErrorMessage> errorMessages = new List<ErrorMessage>();
        for(FlowExecutionErrorEvent evt: flowExecutionErrorEvents){
            errorMessages.add(new ErrorMessage(evt.FlowApiName,evt));
        }
        IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
        iErrorLogger.logMessages(errorMessages);
        iErrorLogger.flush();
    }
}