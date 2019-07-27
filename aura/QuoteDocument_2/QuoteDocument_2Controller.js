/**
 * Created by Spring7 on 5/8/2019.
 */
({
    closeModel : function (component,event,helper) {
        $A.get("e.force:closeQuickAction").fire()
    },
    doInit : function (component,event,helper) {
        helper.getGeneratePDFContent(component,event,helper);
    },
    saveToOpportunity : function (component,event,helper) {
        helper.saveToOpportunity (component,event,helper);
    }
})