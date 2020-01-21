trigger FlowExecutionErrorTrigger  on FlowExecutionErrorEvent (after insert) {
    for(FlowExecutionErrorEvent evt: (List<FlowExecutionErrorEvent>) Trigger.new){
        ILoggingManager iloggingManager = ServiceFactory.getInstance().getLoggingManagerInstance();
        iloggingManager.logMessage(Log.ProcessType.Warning, evt.ErrorMessage  ,'FlowError');
    }
}