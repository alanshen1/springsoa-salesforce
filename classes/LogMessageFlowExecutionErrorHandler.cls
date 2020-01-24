public class LogMessageFlowExecutionErrorHandler {
    public static void logMessages(List<ErrorMessage> errorMessages){
        System.debug('LogMessageFlowExecutionErrorHandler.logMessages errorMessages: ' + JSON.serialize(errorMessages));
        //ILogger ilogger = ServiceFactory.getInstance().getLoggingInstance();
        //ilogger.logMessages(logMessages);
        //ErrorLogger.flush();
    }
}