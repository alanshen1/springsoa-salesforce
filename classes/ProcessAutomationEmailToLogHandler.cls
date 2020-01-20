global class ProcessAutomationEmailToLogHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        System.debug('ProcessAutomationEmailToLogHandler handleInboundEmail'+JSON.serialize(email));
        
        //Log__c log = new Log__c();

        //log.Subject__c 		= email.subject;
        //log.Email_Body__c 	= email.htmlBody;
        //log.From_Email__c 	= email.fromAddress;
        
        //insert log;
        result.success = false;
        return result;
    }
}