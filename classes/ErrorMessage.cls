/**
 * LogMessage wrapper to parse/generate log message.
 */

public without sharing class ErrorMessage {

    public ProcessType iProcessType;
    public String payload;

    @InvocableVariable public String errorMessage;
    @InvocableVariable public String source;
    @InvocableVariable public String stackTrace;
    @InvocableVariable public String userId;

    /* Email Fields */
    public String emailSubject;
    public String emailBody;

    public enum ProcessType {
        CustomPlatformEvent, Batch, EmailHandler, Flow, Warning, Error
    }

    public ErrorMessage() {
    }

    public ErrorMessage(String source, Exception ex) {
        this.source = source;
        this.errorMessage = ex.getMessage();
        this.stackTrace = ex.getStackTraceString();

        System.debug(' ErrorMessage.ErrorMessage source: ' + JSON.serialize(source));
    }

    public ErrorMessage(String source, FlowExecutionErrorEvent flowExecutionErrorEvent) {
        this.source = source;
        this.errorMessage = flowExecutionErrorEvent.ErrorMessage;
        this.userId = flowExecutionErrorEvent.UserId;
        this.payload = getJSONString(flowExecutionErrorEvent);

        System.debug(' ErrorMessage.ErrorMessage source: ' + JSON.serialize(source));
        System.debug(' ErrorMessage.ErrorMessage flowExecutionErrorEvent: ' + JSON.serialize(flowExecutionErrorEvent));
    }

    public ErrorMessage(String source, BatchApexErrorEvent batchApexErrorEvent) {
        this.source = source;
        this.stackTrace = batchApexErrorEvent.StackTrace;
        this.errorMessage = batchApexErrorEvent.Message;
        this.payload = getJSONString(batchApexErrorEvent);

        System.debug(' ErrorMessage.ErrorMessage source: ' + JSON.serialize(source));
        System.debug(' ErrorMessage.ErrorMessage batchApexErrorEvent: ' + JSON.serialize(batchApexErrorEvent));
    }

    public ErrorMessage(ErrorEvent__e errorEvent) {
        this.source = errorEvent.Source__c;
        this.errorMessage = errorEvent.Error_Message__c;
        this.userId = errorEvent.UserId__c;
        this.payload = getJSONString(errorEvent);

        System.debug(' ErrorMessage.ErrorMessage loggingEvent: ' + JSON.serialize(errorEvent));
    }

    public ErrorMessage(String source, Messaging.InboundEmail email) {
        this.source = source;
        this.emailSubject = email.subject;
        this.emailBody = email.htmlBody;
        this.payload = getJSONString(email);

        System.debug(' ErrorMessage.ErrorMessage source: ' + JSON.serialize(source));
        System.debug(' ErrorMessage.ErrorMessage email: ' + JSON.serialize(email));
    }

    private String getJSONString(Object serializeObject) {
        try {
            return JSON.serialize(serializeObject);
        } catch (Exception ex) {
            return '';
        }
    }
}