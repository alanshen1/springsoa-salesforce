({
    handleClick : function(component, event, helper) {

        var accObj = component.get("v.selectedLookUpRecord");
        var accountName = component.get("v.SearchKeyWord");
        console.log(accObj.Id);
        console.log(accountName);
        var action = component.get('c.fetchOpportunity');
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.lstOpp', response.getReturnValue());
                component.set('v.dataAvailable',true);
            }
        });
        $A.enqueueAction(action);
    }
})