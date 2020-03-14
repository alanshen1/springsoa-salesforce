/**
 * Created by spring2 on 13-03-2020.
 */

trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if (Trigger.isInsert && Trigger.isBefore) {
    }

    if (Trigger.isInsert && Trigger.isAfter) {
        createDefaultOpportunitiesOnAccount.afterInsert(Trigger.new);
    }

    if (Trigger.isUpdate && Trigger.isBefore) {
    }

    if (Trigger.isUpdate && Trigger.isAfter) {
        createDefaultOpportunitiesOnAccount.afterUpdate(Trigger.new);
    }
}