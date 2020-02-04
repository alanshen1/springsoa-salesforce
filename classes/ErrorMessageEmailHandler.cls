global class ErrorMessageEmailHandler implements Messaging.InboundEmailHandler{
    
	 global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env) {
        System.debug(' ErrorMessageEmailHandler.handleInboundEmail email: ' + JSON.serialize(email));
         
        IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
        iErrorLogger.logMessage(new ErrorMessage('', email, 'EmailHandler'));
        iErrorLogger.flush();

        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        result.success = false;
        return result;
    }

}