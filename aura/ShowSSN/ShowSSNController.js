/**
 * Created by spring4 on 05-12-2019.
 */

({
    showSSN: function (cmp,eve,helper) {
        var recordId = cmp.get("v.recordId");
        var action = cmp.get("c.getSSN");
        action.setParams({
            recordId : cmp.get("v.recordId"),
            key : cmp.get("v.key")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
               cmp.set("v.ssn",response.getReturnValue());
                cmp.set("v.isValid",true);
            }
            else if (state === "INCOMPLETE") {
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                        cmp.set("v.error",errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
});