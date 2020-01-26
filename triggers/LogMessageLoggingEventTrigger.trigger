trigger LogMessageLoggingEventTrigger on LoggingEvent__e (after insert) {
    System.debug('. LoggingEvent__e:');
    LogMessageLoggingEventTriggerHandler.createErrorMessage(Trigger.New);
}