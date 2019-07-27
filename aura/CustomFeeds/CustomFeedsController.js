({
    // Handle component initialization
    doInit : function(component, event, helper) {
        var action = component.get("c.getFeedCount");
        action.setParams({
            recordId : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var errors = response.getError();
            if(errors.length>0){console.log('error>>'+ errors[0].message)}
            if (state === "SUCCESS") {
                component.set("v.count",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    toggleSection : function(component, event, helper) {
        // dynamically get aura:id name from 'data-auraId' attribute
        var sectionAuraId = event.target.getAttribute("data-auraId");
        // get section Div element using aura:id
        var sectionDiv = component.find(sectionAuraId).getElement();
        /* The search() method searches for 'slds-is-open' class, and returns the position of the match.
         * This method returns -1 if no match is found.
        */
        var sectionState = sectionDiv.getAttribute('class').search('slds-is-open');

        // -1 if 'slds-is-open' class is missing...then set 'slds-is-open' class else set slds-is-close class to element
        if(sectionState == -1){
            sectionDiv.setAttribute('class' , 'slds-section slds-is-open');
        }else{
            sectionDiv.setAttribute('class' , 'slds-section slds-is-close');
        }
    }
})