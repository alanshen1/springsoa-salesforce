trigger FlowExecutionErrorEventTrigger on FlowExecutionErrorEvent (after insert) {

    if(Trigger.isAfter && Trigger.isInsert){
        FlowExecutionErrorEventTriggerHandler.afterInsert(Trigger.new);
    }

}