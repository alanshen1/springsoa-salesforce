trigger OpportunityTrigger on Opportunity (before insert) {
	if(trigger.isAfter && trigger.isInsert){
        OpportunityTriggerHandler.afterInsert(trigger.new);
    }
    if(trigger.isAfter && trigger.isUpdate){
        OpportunityTriggerHandler.afterUpdate(trigger.new,trigger.oldMap);
    }
}