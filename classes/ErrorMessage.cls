/**
 * LogMessage wrapper to parse/generate log message.
 */
public without sharing class ErrorMessage {

    /*
     * payload of exception : eg:- Exception StackTrace
    */
    public String payload;

    /**
     * error type would :
     *      ASYNC_APEX : When raise custom platform event and it will handle by ProcessBuilder and apex trigger
     *      SYNC_APEX : When Directly calling ErrorLogger method to log ErrorMessage
     *      BATCH_APEX : When Batch error will handle from Process Builder / Trigger
     *      SCREEN_FLOW : When ScreenFlow error will handle from Process Builder / Trigger
     *      EMAIL_HANDLER : When Error Email sends from salesforce
     */
    @InvocableVariable public String errorType;

    /**
     * this is error message
     */
    @InvocableVariable public String errorMessage;

    /**
     *this is source from where exception occurs
     */
    @InvocableVariable public String source;

    /**
     * stack trace of exception/error
     */
    @InvocableVariable public String stackTrace;

    /**
     *Context user of Error
     */
    @InvocableVariable public String userId;

    /**
     * Email Fields
     * This is used for PB and Automation flow, where we can not capture error using PB, so we rely on emails
     */
    public String emailSubject;
    public String emailBody;

    public ErrorMessage() {
    }

    public ErrorMessage(String source, Exception ex,String errorType) {
        this.source = source;
        this.errorMessage = ex.getMessage();
        this.stackTrace = ex.getStackTraceString();
        this.errorType = errorType;
        System.debug(' ErrorMessage.ErrorMessage source: ' + JSON.serialize(source));
    }

    public ErrorMessage(String source, FlowExecutionErrorEvent flowExecutionErrorEvent, String errorType) {
        this.source = source;
        this.errorMessage = flowExecutionErrorEvent.ErrorMessage;
        this.userId = flowExecutionErrorEvent.UserId;
        this.payload = getJSONString(flowExecutionErrorEvent);
        this.errorType = errorType;

        System.debug(' ErrorMessage.ErrorMessage source: ' + JSON.serialize(source));
        System.debug(' ErrorMessage.ErrorMessage flowExecutionErrorEvent: ' + JSON.serialize(flowExecutionErrorEvent));
    }

    public ErrorMessage(String source, BatchApexErrorEvent batchApexErrorEvent,String errorType) {
        this.source = source;
        this.stackTrace = batchApexErrorEvent.StackTrace;
        this.errorMessage = batchApexErrorEvent.Message;
        this.payload = getJSONString(batchApexErrorEvent);
        this.errorType = errorType;

        System.debug(' ErrorMessage.ErrorMessage source: ' + JSON.serialize(source));
        System.debug(' ErrorMessage.ErrorMessage batchApexErrorEvent: ' + JSON.serialize(batchApexErrorEvent));
    }

    public ErrorMessage(ErrorEvent__e errorEvent,String errorType) {
        this.source = errorEvent.Source__c;
        this.errorMessage = errorEvent.Error_Message__c;
        this.userId = errorEvent.UserId__c;
        this.payload = getJSONString(errorEvent);
        this.errorType = errorType;

        System.debug(' ErrorMessage.ErrorMessage loggingEvent: ' + JSON.serialize(errorEvent));
    }

    public ErrorMessage(String source, Messaging.InboundEmail email,String errorType) {
        this.source = source;
        this.emailSubject = email.subject;
        this.emailBody = email.htmlBody;
        this.payload = getJSONString(email);
        this.errorType = errorType;

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