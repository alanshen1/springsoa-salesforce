({
    cloneOpportunityAction : function(component, event, helper) {
        var action = component.get('c.cloneOpportunity'); 
        action.setParams({
            "oppoId" : component.get('v.recordId'),
            "isCloneWithProduct" : component.get('v.isCloneWithProduct')
        });
        action.setCallback(this, function(a){
            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
               	var returnvalue = a.getReturnValue();
                this.showToast('Opportunity has been Cloned', 'Success', 'Success');
                this.navigateToSobject(returnvalue.Id);
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                    	this.showToast(errors[0].message , 'Error', 'Error');
                    }
                } else {
                    this.showToast("Unknow Erro" , 'Error', 'Error');
                }
            } 
        });
        $A.enqueueAction(action);
    },
    
    showToast : function(message, Title, type) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": Title,
            "message": message,
            "type" : type
        });
        toastEvent.fire();
    },
    
    navigateToSobject : function(recordId) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordId
        });
        navEvt.fire()
    }
})