trigger LoggingEventTrigger on LoggingEvent__e (after insert) {
	for(LoggingEvent__e evt: (List<LoggingEvent__e>)Trigger.new){
        ILoggingManager iloggingManager = ServiceFactory.getInstance().getLoggingManagerInstance();
        iloggingManager.logMessage(Log.ProcessType.Error,evt.Error_Message__c,'CustomPlatformEvent');
    }
}