({
	handleClick : function(component, event, helper) {
		debugger;
        var accObj = component.get("v.selectedLookUpRecord");
        var accountName = component.get("v.accountName");
        console.log(accObj.Id);
        console.log(accountName);
	}
})