trigger FlowExecutionErrorTrigger  on FlowExecutionErrorEvent (after insert) {
     // FlowExecutionErrorTrigger
    for(FlowExecutionErrorEvent evt: (List<FlowExecutionErrorEvent>) Trigger.new){
        ILoggingManager iloggingManager = ServiceFactory.getInstance().getLoggingManagerInstance();
        iloggingManager.logMessage(Log.ProcessType.Flow,evt.ErrorMessage,'GENERIC',evt.FlowApiName );
    }
}