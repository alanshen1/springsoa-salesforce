/**
 * Created by Chintan Shah on 12/20/2019.
 */

trigger AccountTrigger on Account (after update) {
    if( Trigger.isAfter && Trigger.isUpdate ) {
        AccountTriggerHandler.afterUpdate(Trigger.Old, Trigger.New, Trigger.oldMap, Trigger.newMap);
    }
}