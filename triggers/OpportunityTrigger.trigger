/**
* cshah on : 03-12-2020
* */
trigger OpportunityTrigger on Opportunity (after insert, after update) {
    if(trigger.isAfter && trigger.isInsert){
        OpportunityTriggerHandler.afterInsert(trigger.new,trigger.isInsert);
    }
    if(trigger.isAfter && trigger.isUpdate){
        OpportunityTriggerHandler.afterUpdate(trigger.new,trigger.oldMap);
    }
}