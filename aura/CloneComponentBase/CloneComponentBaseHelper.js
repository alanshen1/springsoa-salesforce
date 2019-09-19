/**
 * Created by Spring7 on 9/19/2019.
 */

({
    closeQuickActionModal : function(component){
        var dismissActionPanel = $A.get('e.force:closeQuickAction');
        dismissActionPanel.fire();
    },
    createRecord : function(component, defaultFieldValues) {
        delete defaultFieldValues['Id'];
        var createRecordEvent = $A.get('e.force:createRecord');
        var sObjectApiName = component.get("v.sObjectApiName");
        createRecordEvent.setParams({
            entityApiName: sObjectApiName,
            defaultFieldValues: defaultFieldValues,
        });
        createRecordEvent.fire();
    }
})