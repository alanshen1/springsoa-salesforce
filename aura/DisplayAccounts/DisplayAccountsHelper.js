/**
 * Created by Spring7 on 4/7/2020.
 */

({
    getAllAccounts: function (component, event, helper) {
        var action = component.get("c.getAllAccounts");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var allAccounts = response.getReturnValue();
                var accountsToShow = [];
                var rowsCount = component.get("v.rowsCount");

                for(let i=0;i<allAccounts.length;i++){
                    allAccounts[i].recordURL = '/'+allAccounts[i].Id;
                }
                component.set("v.allAccounts",allAccounts);
                for(let j=0;j<rowsCount; j++){
                    accountsToShow.push(allAccounts[j]);
                }
                component.set("v.accountsToShow",accountsToShow);
                component.set("v.allRecordCount",allAccounts.length);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
});