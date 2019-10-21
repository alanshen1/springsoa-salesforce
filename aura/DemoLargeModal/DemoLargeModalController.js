/**
 * Created by Chintan Shah on 10/20/2019.
 */

({

    closeModel : function (component,event,helper) {
        $A.get("e.force:closeQuickAction").fire()
    }

});