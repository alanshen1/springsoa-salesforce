/**
 * Created by spring4 on 30-05-2019.
 */
({

    showForm : function (component, evt, helper){
        var btnName = evt.getSource().getLocalId();
        var data = {};
        data.objectApiName = component.get('v.objectApiName');
        if(btnName === 'Update'){
            data.recordId = component.get('v.recordId')
        }
        var modalBody;
        $A.createComponent("c:updateRecord", data,
            function(content, status) {
                if (status === "SUCCESS") {
                    modalBody = content;
                    component.find('overlayLib').showCustomModal({
                        header: btnName+" "+data.objectApiName,
                        body: modalBody,
                        showCloseButton: true,
                        cssClass: "mymodal",
                        closeCallback: function() {
                            //alert('You closed the alert!');
                        }
                    })
                 }
        });
    }
})