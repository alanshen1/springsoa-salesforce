/**
 * Created by Spring7 on 9/19/2019.
 */

({
    doInit: function(component, event, helper) {
        var action = component.get('c.getRecord');
        var recordId = component.get('v.recordId');
        var fieldSetName = component.get('v.fieldSetName');
        var sObjectApiName = component.get('v.sObjectApiName');
        action.setParams({recordId: recordId,fieldSetName:fieldSetName,sObjectApiName:sObjectApiName});
        action.setCallback(this, function (response) {
            if(response.getState() === 'SUCCESS'){
                var defaultFieldValues = response.getReturnValue();
                helper.createRecord(component, defaultFieldValues);
                helper.closeQuickActionModal(component);
            }else if (response.getState() ==="ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "Error",
                            "message": errors[0].message
                        });
                        toastEvent.fire();
                        helper.closeQuickActionModal(component);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
});