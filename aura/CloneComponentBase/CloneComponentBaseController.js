/**
 * Created by Spring7 on 9/19/2019.
 */

({
    doInit: function(component, event, helper) {
        var action = component.get('c.getRecord');
        var recordId = component.get('v.recordId');
        var fieldSetName = component.get('v.fieldSetName');
        action.setParams({recordId: recordId,fieldSetName:fieldSetName,sObjectApiName:sObjectApiName});
        action.setCallback(this, function (response) {
            if(response.getState() === 'SUCCESS'){
                var defaultFieldValues = response.getReturnValue();
                helper.createRecord(component, defaultFieldValues);
                helper.closeQuickActionModal(component);
            }
        });
        $A.enqueueAction(action);
    }
});