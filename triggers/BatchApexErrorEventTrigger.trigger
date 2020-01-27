trigger BatchApexErrorEventTrigger on BatchApexErrorEvent (after insert) {

    if(Trigger.isAfter && Trigger.isInsert){
        BatchApexErrorEventTriggerHandler.afterInsert(Trigger.new);
    }

}