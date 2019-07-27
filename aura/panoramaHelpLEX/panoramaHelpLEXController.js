/**
 * Created by Spring7 on 7/9/2019.
 */

({
    navigateToCase: function(component, event) {
        var caseId = event.getParam('result');
        var workspaceAPI = component.find("workspace");
        workspaceAPI.getFocusedTabInfo().then(function(response) {
            workspaceAPI.openTab({
                url: '#/sObject/'+caseId+'/view',
                focus: true
            });
        }).catch(function(error) {
            console.log(error);
        });
        var utilityAPI = component.find("utilitybar");
        utilityAPI.minimizeUtility();
    }
})