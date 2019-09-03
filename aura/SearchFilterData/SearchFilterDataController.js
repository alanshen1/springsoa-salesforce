({
    handleClick : function(component, event, helper) {

        var accObj = component.get("v.selectedLookUpRecordAcc");
        var accountName = component.get("v.SearchKeyWordAcc");
        var conObj = component.get("v.selectedLookUpRecordCon");
        var contactName = component.get("v.SearchKeyWordCon");

        var action = component.get('c.fetchDataForFilters');
        action.setParams({
            'accountId': accObj.Id!= undefined? accObj.Id : '',
            'accountStr' : accountName,
            'contactId': conObj.Id!= undefined? conObj.Id : '',
            'contactStr' : contactName
        });
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                debugger;
                console.log(JSON.parse(JSON.stringify(response.getReturnValue())));
                component.set('v.lstOpp', response.getReturnValue());
                component.set('v.dataAvailable',true);
                setTimeout(function(){
                    var uid = Math.ceil(Math.random() * 20);
                    helper.createTable(component,uid);

                }, 500);
            }
        });
        $A.enqueueAction(action);
    }
})