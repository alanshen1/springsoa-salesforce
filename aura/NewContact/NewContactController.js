/**
 * Created by Spring7 on 12/4/2019.
 */

({
    doInit: function (component, event, helper) {
        var pageReference = component.get("v.pageReference");
        console.log('NewContactControllerJS.doInit pageReference : ' + JSON.stringify(pageReference));

        if (pageReference) {
            var recordTypeId = pageReference.state.recordTypeId;
            var state = pageReference.state;
            var base64Context = state.inContextOfRef;
            var addressableContext = {recordId: ''};
            if (base64Context && base64Context.startsWith('1\.')) {
                base64Context = base64Context.substring(2);
                addressableContext = JSON.parse(window.atob(base64Context));
                addressableContext = addressableContext.attributes;
            }
            console.log(addressableContext);
            if (addressableContext.recordId !== undefined) {
                var recordTypeId = pageReference.state.recordTypeId;
                var action = component.get('c.getContact');
                if (recordTypeId == undefined) {
                    console.log(recordTypeId)
                    action.setParams({
                        accountRecordId: addressableContext.recordId,
                        recordTypeId: null
                    });
                } else {
                    console.log(recordTypeId)
                    action.setParams({
                        accountRecordId: addressableContext.recordId,
                        recordTypeId: recordTypeId
                    });
                }
                debugger;
                action.setCallback(this, function (response) {
                    if (response.getState() === 'SUCCESS') {
                        var defaultFieldValues = response.getReturnValue();
                        helper.createRecord(component, defaultFieldValues);
                    }
                });
                $A.enqueueAction(action);
            } else {
                helper.createRecord(component, '');
            }
        }
    }
})