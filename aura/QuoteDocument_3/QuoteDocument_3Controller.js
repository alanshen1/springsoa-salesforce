({
    closeModel : function (component,event,helper) {
        $A.get("e.force:closeQuickAction").fire()
    },
    saveAndEmail : function (component,event,helper) {
        helper.saveAndEmail(component,event,helper);
    },
    saveToOpportunity : function (component,event,helper) {
        helper.saveToOpportunity (component,event,helper);
    }
})