/**
 * LogMessage wrapper to parse/generate log message.
 */

public without sharing class LogMessage {

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

    public LogMessage(String source, Exception ex) {
        this.source = source;
        this.errorMessage = ex.getMessage();
        this.stackTrace = ex.getStackTraceString();
        this.payload = JSON.serialize(ex);
    }

    public LogMessage(String source, FlowExecutionErrorEvent flowExecutionErrorEvent) {
        this.source = source;
        this.errorMessage = flowExecutionErrorEvent.ErrorMessage;
        this.userId = flowExecutionErrorEvent.UserId;
        this.payload = JSON.serialize(flowExecutionErrorEvent);
    }

    public LogMessage(String source, BatchApexErrorEvent batchApexErrorEvent) {
        this.source = source;
        this.stackTrace = batchApexErrorEvent.StackTrace;
        this.errorMessage = batchApexErrorEvent.Message;
        this.payload = JSON.serialize(batchApexErrorEvent);
    }

    public LogMessage(LoggingEvent__e loggingEvent) {
        this.source = loggingEvent.Source__c;
        this.errorMessage = loggingEvent.Error_Message__c;
        this.userId = loggingEvent.User__c;
        this.payload = JSON.serialize(loggingEvent);
    }

    public LogMessage(String source, Messaging.InboundEmail email) {
        this.source = source;
        this.emailSubject = email.subject;
        this.emailBody = email.htmlBody;
        this.payload = JSON.serialize(email);
    }
}