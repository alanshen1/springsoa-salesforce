trigger LogMessageBatchApexErrorEventTrigger on BatchApexErrorEvent (after insert) {
    LogMessageBatchApexErrorHandler.createErrorMessage(Trigger.New);
}