trigger BatchApexErrorEventTrigger on BatchApexErrorEvent (after insert) {
    for(BatchApexErrorEvent evt:Trigger.new){
        ILoggingManager iloggingManager = ServiceFactory.getInstance().getLoggingManagerInstance();
        iloggingManager.logMessage(Log.ProcessType.Warning,evt.Message,'BatchError');
    }
}