public without sharing class ErrorLogger {
/*
    private static List<LogMessage> logs { get; set; }
    private static List<LogMessage> logEvents { get; set; }

    public static void logMessage(LogMessage logMessage) {
        System.debug('Logger.logMessage logMessage: ' + logMessage);
        logMessages(new List<LogMessage>{
                logMessage
        });
    }

    public static void logMessages(List<LogMessage> logMessages) {
        logs = new List<LogMessage>();
        for (LogMessage logMessage : logMessages) {
            logs.add(logMessage);
        }
    }

    public static void fireLogEvent(LogMessage logMessage) {
        fireLogEvents(new List<LogMessage>{
                logMessage
        });
    }

    public static void fireLogEvents(List<LogMessage> logMessages) {
        for (LogMessage logMessage : logMessages) {
            logEvents.add(logMessage);
        }
    }

    @InvocableMethod(label='LogMessage')
    public static void logMessage(LogMessage[] logMessages) {
        LogMessage logMessage;
        System.debug('Logger.logMessage logMessages: ' + JSON.serialize(logMessages));
        if(!logMessages.isEmpty()){
            logMessage = logMessages[0];
        }else{
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in Logger, Log Message not found. ');
            return;
        }
        try {
            System.debug('Logger.logMessage logMessage: ' + JSON.serialize(logMessage));
            logMessage(logMessage);
        } catch(Exception e) {
            System.debug('Logger.logMessage e: ' + e);
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in Logger' + e.getMessage() );
        }finally {
            flush();
        }

    }*/

    /**
     * Commit logs into database.
     */
    /*
    public void flush() {
        if (logs!=null && !logs.isEmpty()) {
            List<LogMessage__c> logMessages = new List<LogMessage__c>();
            for (LogMessage logMessage : logs) {
                logMessages.add(parseLog(logMessage));
            }

            insert logMessages;
        }

        if (logEvents!=null && !logEvents.isEmpty()) {
            List<LogEvent__e> events = new List<LogEvent__e>();
            for (LogMessage logMessage : logEvents) {
                events.add(parseLogEvent(logMessage));
            }
            EventBus.publish(events);
        }

        logs.clear();
    }

    public static void fireLogEvent(String errorMessage, String processType, String source) {
        LoggingEvent__e loggingEvent = new LoggingEvent__e();
        loggingEvent.Error_Message__c = errorMessage;
        loggingEvent.ProcessType__c = processType;
        loggingEvent.Source__c = source;
        loggingEvent.User__c = UserInfo.getUserId();
        EventBus.publish(loggingEvent);
    }*/

    /**
     * Parse log and return LogMessage__c.
     *
     * @param logMessage
     *
     * @return LogMessage__c
     */
    /*
    @TestVisible
    private static LogMessage__c parseLog(LogMessage logMessage) {
        return new LogMessage__c(
                Email_Subject__c = logMessage.emailSubject,
                Email_Body__c = logMessage.emailBody,
                Process_Type__c = (logMessage.iProcessType != null ? logMessage.iProcessType.name() : ''),
                Error_Message__c = logMessage.errorMessage,
                Source__c = logMessage.source,
                StackTrace__c = logMessage.stackTrace,
                Payload__c = logMessage.payload,
                User__c = (String.isNotBlank(logMessage.userId) ? logMessage.userId : UserInfo.getUserId()),
                Tracking_History__c = ServiceFactory.getInstance().getCheckpointManagerInstance().getCheckpointDetail()
        );
    }*/

    /**
     * Parse log event and return LogEvent__c.
     *
     * @param logMessage
     *
     * @return LogEvent__c
     */
    /*@TestVisible
    private static LogEvent__e parseLogEvent(LogMessage logMessage) {
        return new LogEvent__e(
                Error_Message__c = logMessage.errorMessage,
                Source__c = logMessage.source,
                User__c = UserInfo.getUserId()
        );
    }*/
}