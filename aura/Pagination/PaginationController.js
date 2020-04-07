/**
 * Created by Spring7 on 4/8/2020.
 */

({
    firstClicked: function (component, event, helper) {
        component.set("v.pageNumber", 1);
    },
    previousClicked: function (component, event, helper) {
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", --pageNumber);

        var myEvent = component.getEvent("paginationNotifier");
        myEvent.setParams({"pageNumber": pageNumber});
        myEvent.fire();

    },
    nextClicked: function (component, event, helper) {
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", ++pageNumber);
        var myEvent = component.getEvent("paginationNotifier");
        myEvent.setParams({"pageNumber": pageNumber});
        myEvent.fire();
    },
    lastClicked: function (component, event, helper) {
    }
});