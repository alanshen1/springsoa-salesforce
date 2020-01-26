public without sharing class ErrorLogger implements IErrorLogger{

    private static List<ErrorMessage> logs { get; set; }
    private static List<ErrorMessage> logEvents { get; set; }
    private static IErrorLogger errorLoggerinstance = null;
    private ErrorLogger(){}

    public static IErrorLogger getErrorLoggerInstance(){
        if(errorLoggerinstance == null){
            errorLoggerinstance = new ErrorLogger();
        }
        return errorLoggerinstance;
    }

    public void logMessage(ErrorMessage errorMessage) {
        System.debug('Logger.logMessage logMessage: ' + errorMessage);
        logMessages(new List<ErrorMessage>{
                errorMessage
        });
    }

    public void logMessages(List<ErrorMessage> errorMessages) {
        logs = new List<ErrorMessage>();
        logEvents = new List<ErrorMessage>();
        for (ErrorMessage errorMessage : errorMessages) {
            logs.add(errorMessage);
        }
    }

    public void fireLogEvent(ErrorMessage errorMessage) {
        fireLogEvents(new List<ErrorMessage>{
                errorMessage
        });
    }

    public void fireLogEvents(List<ErrorMessage> errorMessages) {
        logs = new List<ErrorMessage>();
        logEvents = new List<ErrorMessage>();
        for (ErrorMessage errorMessage : errorMessages) {
            logEvents.add(errorMessage);
        }
    }

    @InvocableMethod(label='ErrorMessage')
    public static void logMessage(ErrorMessage[] errorMessages) {
        ErrorMessage errorMessage;
        System.debug('Logger.logMessage logMessages: ' + JSON.serialize(errorMessages));
        IErrorLogger iErrLogger = ErrorLogger.getErrorLoggerInstance();
        if(!errorMessages.isEmpty()){
            errorMessage = errorMessages[0];
        }else{
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in ErrorLogger, ErrorMessage not found. ');
            return;
        }
        try {
            System.debug('ErrorLogger.logMessage logMessage: ' + JSON.serialize(errorMessage));
            iErrLogger.logMessage(errorMessage);
        } catch(Exception e) {
            System.debug('Logger.logMessage e: ' + e);
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in Logger' + e.getMessage() );
        }finally {
            iErrLogger.flush();
        }
    }

    /**
     * Commit logs into database.
     */
    public void flush() {
        if (logs!=null && !logs.isEmpty()) {
            List<ErrorMessage__c> errorMessages = new List<ErrorMessage__c>();
            for (ErrorMessage errorMessage : logs) {
                errorMessages.add(parseLog(errorMessage));
            }
            insert errorMessages;
        }
        System.debug('ErrorLogger.flush logEvents: ' + JSON.serialize(logEvents));
        if (logEvents!=null && !logEvents.isEmpty()) {
            List<LogEvent__e> events = new List<LogEvent__e>();
            for (ErrorMessage errorMessage : logEvents) {
                events.add(parseLogEvent(errorMessage));
            }
            EventBus.publish(events);
        }
        logEvents.clear();
        logs.clear();
    }

    /**
     * Publish Custom LoggingEvent__e
     */
    public void fireLogEvent(String errorMessage, String processType, String source) {
        LoggingEvent__e loggingEvent = new LoggingEvent__e();
        loggingEvent.Error_Message__c = errorMessage;
        loggingEvent.ProcessType__c = processType;
        loggingEvent.Source__c = source;
        loggingEvent.User__c = UserInfo.getUserId();
        EventBus.publish(loggingEvent);
    }

    /**
     * Parse log and return LogMessage__c.
     *
     * @param logMessage
     *
     * @return LogMessage__c
     */
    @TestVisible
    private ErrorMessage__c parseLog(ErrorMessage errorMessage) {
        return new ErrorMessage__c(
                Email_Subject__c = errorMessage.emailSubject,
                Email_Body__c = errorMessage.emailBody,
                Process_Type__c = (errorMessage.iProcessType != null ? errorMessage.iProcessType.name() : ''),
                Error_Message__c = errorMessage.errorMessage,
                Source__c = errorMessage.source,
                StackTrace__c = errorMessage.stackTrace,
                Payload__c = errorMessage.payload,
                User__c = (String.isNotBlank(errorMessage.userId) ? errorMessage.userId : UserInfo.getUserId()),
                Tracking_History__c = ServiceFactory.getInstance().getCheckpointManagerInstance().getCheckpointDetail()
        );
    }

    /**
     * Parse log event and return LogEvent__c.
     *
     * @param logMessage
     *
     * @return LogEvent__c
     */
    @TestVisible
    private LogEvent__e parseLogEvent(ErrorMessage errorMessage) {
        return new LogEvent__e(
                Error_Message__c = errorMessage.errorMessage,
                Source__c = errorMessage.source,
                User__c = UserInfo.getUserId()
        );
    }
}