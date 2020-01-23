trigger LogMessageFlowExecutionErrorTrigger  on FlowExecutionErrorEvent (after insert) {
    for(FlowExecutionErrorEvent evt: (List<FlowExecutionErrorEvent>) Trigger.new){
		LogMessage logMessage = new LogMessage(evt.FlowApiName,evt);		
        ILogger ilogger = ServiceFactory.getInstance().getLoggingInstance();
        ilogger.logMessage(logMessage);
    }
}