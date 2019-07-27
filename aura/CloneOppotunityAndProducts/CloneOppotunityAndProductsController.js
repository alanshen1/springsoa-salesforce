({
	doInit : function(component, event, helper) {
		helper.cloneOpportunityAction(component, event, helper);
		// setTimeout(function () {$A.get('e.force:closeQuickAction').fire();}, 1000);
	}
})