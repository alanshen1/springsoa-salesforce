trigger LogMessageFlowExecutionErrorTrigger  on FlowExecutionErrorEvent (after insert) {
    LogMessageFlowExecutionErrorHandler.createErrorMessage(Trigger.New);
}