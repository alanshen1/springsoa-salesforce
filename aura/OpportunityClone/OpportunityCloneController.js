({
    createOpportunity: function (component) {
        var createRecordEvent = $A.get('e.force:createRecord');
        if ( createRecordEvent ) {
            createRecordEvent.setParams({
                'entityApiName': 'Opportunity',
                'defaultFieldValues': {
                    'Name' : 'Test',
                    'Amount':'10'
                }
            });
            createRecordEvent.fire();
        } else {
            alert("Opportunity creation not supported");
        }
    }
})