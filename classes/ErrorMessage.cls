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
    public ErrorMessage(){}
    public ErrorMessage(String source, Exception ex) {
        this.source = source;
        this.errorMessage = ex.getMessage();
        this.stackTrace = ex.getStackTraceString();
        try{this.payload = JSON.serialize(ex);}catch(Exception exp){this.payload = '';}
    }

    public ErrorMessage(String source, FlowExecutionErrorEvent flowExecutionErrorEvent) {
        this.source = source;
        this.errorMessage = flowExecutionErrorEvent.ErrorMessage;
        this.userId = flowExecutionErrorEvent.UserId;
        try{this.payload = JSON.serialize(flowExecutionErrorEvent);}catch(Exception ex){this.payload = '';}

    }

    public ErrorMessage(String source, BatchApexErrorEvent batchApexErrorEvent) {
        this.source = source;
        this.stackTrace = batchApexErrorEvent.StackTrace;
        this.errorMessage = batchApexErrorEvent.Message;
        try{this.payload = JSON.serialize(batchApexErrorEvent);}catch(Exception ex){this.payload = '';}
    }

    public ErrorMessage(LoggingEvent__e loggingEvent) {
        this.source = loggingEvent.Source__c;
        this.errorMessage = loggingEvent.Error_Message__c;
        this.userId = loggingEvent.User__c;
        try{this.payload = JSON.serialize(loggingEvent);}catch(Exception ex){this.payload = '';}
    }

    public ErrorMessage(String source, Messaging.InboundEmail email) {
        this.source = source;
        this.emailSubject = email.subject;
        this.emailBody = email.htmlBody;
        try{this.payload = JSON.serialize(email);}catch(Exception ex){this.payload = '';}
    }
}