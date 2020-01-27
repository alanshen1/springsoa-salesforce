public without sharing class ErrorLogger implements IErrorLogger {

    private static List<ErrorMessage> logs { get; set; }
    private static List<ErrorMessage> publishErrorEvents { get; set; }

    private static IErrorLogger errorLoggerInstance = null;

    private ErrorLogger() {
    }

    public static IErrorLogger getErrorLoggerInstance() {
        if (errorLoggerInstance == null) {
            logs = new List<ErrorMessage>();
            publishErrorEvents = new List<ErrorMessage>();

            errorLoggerInstance = new ErrorLogger();
        }
        return errorLoggerInstance;
    }

    public void logMessage(ErrorMessage errorMessage) {
        logMessages(new List<ErrorMessage>{
                errorMessage
        });
    }

    public void logMessages(List<ErrorMessage> errorMessages) {
        System.debug(' ErrorLogger.logMessages errorMessages: ' + JSON.serialize(errorMessages));

        for (ErrorMessage errorMessage : errorMessages) {
            logs.add(errorMessage);
        }
    }

    public void fireErrorEvent(ErrorMessage errorMessage) {
        fireErrorEvents(new List<ErrorMessage>{
                errorMessage
        });
    }

    public void fireErrorEvents(List<ErrorMessage> errorMessages) {
        System.debug(' ErrorLogger.fireErrorEvents errorMessages: ' + JSON.serialize(errorMessages));

        for (ErrorMessage errorMessage : errorMessages) {
            publishErrorEvents.add(errorMessage);
        }
    }

    @InvocableMethod(Label='ErrorMessage')
    public static void logMessage(ErrorMessage[] errorMessages) {
        System.debug('Logger.logMessage logMessages: ' + JSON.serialize(errorMessages));

        IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
        ErrorMessage errorMessage;
        if (!errorMessages.isEmpty()) {
            errorMessage = errorMessages[0];
        } else {
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in ErrorLogger, ErrorMessage not found. ');
            return;
        }
        try {
            System.debug('ErrorLogger.logMessage logMessage: ' + JSON.serialize(errorMessage));
            iErrorLogger.logMessage(errorMessage);
        } catch (Exception e) {
            System.debug('Logger.logMessage e: ' + e);
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in Logger' + e.getMessage());
        } finally {
            iErrorLogger.flush();
        }
    }

    /**
     * Commit logs into database.
     */
    public void flush() {
        System.debug(' ErrorLogger.flush logs: ' + JSON.serialize(logs));
        if (logs != null && !logs.isEmpty()) {
            List<ErrorMessage__c> errorMessages = new List<ErrorMessage__c>();
            for (ErrorMessage errorMessage : logs) {
                errorMessages.add(parseLog(errorMessage));
            }
            insert errorMessages;
        }
        logs.clear();

        System.debug('ErrorLogger.flush publishErrorEvents: ' + JSON.serialize(publishErrorEvents));
        if (publishErrorEvents != null && !publishErrorEvents.isEmpty()) {
            List<ErrorEvent__e> events = new List<ErrorEvent__e>();
            for (ErrorMessage errorMessage : publishErrorEvents) {
                events.add(parseLogEvent(errorMessage));
            }
            EventBus.publish(events);
        }
        publishErrorEvents.clear();
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
                User__c = (String.isNotBlank(errorMessage.userId) ? errorMessage.userId : UserInfo.getUserId())
        );
    }

    /**
     * Parse log event and return ErrorEvent__e.
     *
     * @param logMessage
     *
     * @return ErrorEvent__e
     */
    @TestVisible
    private ErrorEvent__e parseLogEvent(ErrorMessage errorMessage) {
        return new ErrorEvent__e(
                Error_Message__c = errorMessage.errorMessage,
                Source__c = errorMessage.source,
                UserId__c = UserInfo.getUserId()
        );
    }
}