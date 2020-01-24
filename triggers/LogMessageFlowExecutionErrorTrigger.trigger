trigger LogMessageFlowExecutionErrorTrigger  on FlowExecutionErrorEvent (after insert) {
    List<LogMessage> logMessages = new List<LogMessage>();
    for(FlowExecutionErrorEvent evt: (List<FlowExecutionErrorEvent>) Trigger.new){
        logMessages.add(new LogMessage(evt.FlowApiName,evt));
    }
    LogMessageFlowExecutionErrorHandler.logMessages(logMessages);
}