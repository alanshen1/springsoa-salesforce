global class ProcessAutomationEmailToLogHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        System.debug('ProcessAutomationEmailToLogHandler handleInboundEmail'+JSON.serialize(email));
        return result;
    }
}