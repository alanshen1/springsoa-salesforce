/**
 * Created by spring4 on 20-11-2019.
 */

({
    doInit : function(component, event, helper) {
        var datatColumns = [
            {label: 'Name', fieldName: 'Id', type: 'url',sortable:false,
                typeAttributes: { label: { fieldName: 'Name' }, target: '_blank' }},
            {label: 'Created Date', fieldName: 'CreatedDate', type: 'date',
                typeAttributes:{
                    year: "numeric",
                    month: "numeric",
                    day: "numeric",
                    hour: "numeric",
                    minute: "numeric"
                }}];
        component.set('v.dataColumns',datatColumns);
        console.log(datatColumns);
        var action = component.get("c.auraPreparingData");
        action.setParams({strIds : component.get("v.Ids")});
        action.setCallback(this, function(response) {
            debugger;
            console.log('getReturnValue',response.getReturnValue());
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.allData',response.getReturnValue());
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                            errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})