global class ProcessAutomationEmailToLogHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        System.debug('ProcessAutomationEmailToLogHandler handleInboundEmail'+JSON.serialize(email));
        ErrorMessage errorMessage = new ErrorMessage('',email);

        IErrorLogger iErrLogger = ErrorLogger.getErrorLoggerInstance();
        iErrLogger.logMessage(errorMessage);
        iErrLogger.flush();
        result.success = false;
        return result;
    }
}