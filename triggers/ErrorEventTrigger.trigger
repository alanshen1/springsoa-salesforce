trigger ErrorEventTrigger on ErrorEvent__e (after insert) {

    if(Trigger.isAfter && Trigger.isInsert){
        ErrorEventTriggerHandler.afterInsert(Trigger.new);
    }

}