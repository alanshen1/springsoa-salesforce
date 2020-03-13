/**
 * Created by spring2 on 13-03-2020.
 */

trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if (Trigger.isInsert && Trigger.isBefore) {
        createDefaultOpportunitiesOnAccount.createOpportunities(Trigger.new);
    }

    if (Trigger.isInsert && Trigger.isAfter) {
    }

    if (Trigger.isUpdate && Trigger.isBefore) {
    }

    if (Trigger.isUpdate && Trigger.isAfter) {
    }
}