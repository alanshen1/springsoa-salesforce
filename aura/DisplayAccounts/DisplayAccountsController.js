/**
 * Created by Spring7 on 4/7/2020.
 */

({
    doInit: function (component, event, helper) {
        component.set('v.columns', [
            {label: 'Account name', fieldName: 'recordURL', type: 'url',typeAttributes: {label: {fieldName : "Name"}, target: "_blank"}},
            {label: 'Website', fieldName: 'Website', type: 'url'},
            {label: 'Phone', fieldName: 'Phone', type: 'Phone'},
            {label: 'Rating', fieldName: 'Rating', type: 'Text'},
            {label: 'CreatedDate', fieldName: 'CreatedDate', type: 'Date'}
        ]);
        helper.getAllAccounts(component, event, helper);
    },
    changePage : function(component, event, helper){
        debugger;
        var value = event.getParam("pageNumber");
        alert(value);
    }
});