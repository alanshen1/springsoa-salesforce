({
    saveAndEmail : function (component,event,helper) {
        var action = component.get("c.sendMail");
        action.setParams({recordId : component.get("v.recordId")});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //component.set("v.pdfContent",response.getReturnValue());
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Mail sent and PDF successfully saved to opportunity!"
                });
                toastEvent.fire();
                $A.get("e.force:closeQuickAction").fire()
            }
            else if (state === "INCOMPLETE") {
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    saveToOpportunity : function (component,event,helper) {
        var action = component.get("c.saveQuoteToOpportunity");
        var recordIdObj = component.get("v.recordId");
        console.log(recordIdObj);
        action.setParams({recordId : recordIdObj});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //component.set("v.pdfContent",response.getReturnValue());
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Quote Document successfully save to Opportunity!"
                });
                toastEvent.fire();
                $A.get("e.force:closeQuickAction").fire()
            }
            else if (state === "INCOMPLETE") {
            }
            else if (state === "ERROR") {
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