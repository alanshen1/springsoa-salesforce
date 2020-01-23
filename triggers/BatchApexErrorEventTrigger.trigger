trigger BatchApexErrorEventTrigger on BatchApexErrorEvent (after insert) {
    // BatchApexErrorEventTriggerHandler
    for(BatchApexErrorEvent evt:Trigger.new){
        ILoggingManager iloggingManager = ServiceFactory.getInstance().getLoggingManagerInstance();
        iloggingManager.logMessage(Log.ProcessType.Batch,evt.Message,'GENERIC',evt.AsyncApexJobId);
    }
}