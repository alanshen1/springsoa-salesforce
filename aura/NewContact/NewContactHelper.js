/**
 * Created by Spring7 on 12/4/2019.
 */

({
    createRecord : function(component, defaultFieldValues) {
        var createRecordEvent = $A.get('e.force:createRecord');
        createRecordEvent.setParams({
            entityApiName: 'Contact',
            defaultFieldValues: defaultFieldValues,
        });
        createRecordEvent.fire();
    }
})