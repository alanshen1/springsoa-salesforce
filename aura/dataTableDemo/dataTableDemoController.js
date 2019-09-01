({
    scriptsLoaded : function(component, event, helper) {
        console.log('Script loaded..'); 
    },
    
    doInit : function(component,event,helper){
        //call apex class method
        var action = component.get('c.fetchOpportunity');
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                //set response value in lstOpp attribute on component.
                component.set('v.lstOpp', response.getReturnValue());
                
                // when response successfully return from server then apply jQuery dataTable after 500 milisecond
                setTimeout(function(){ 
                    /*$('#tableId tfoot th').each( function () {
                        var title = $(this).text();
                        $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
                    } );*/
                    
                    $('#tableId thead tr:eq(1) th').each( function () {
                        var title = $('#example thead tr:eq(0) th').eq( $(this).index() ).text();
                        $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
                    } );
                    var table = $('#tableId').DataTable({
                        orderCellsTop: true
                    });
                    debugger;
                    table.columns().every( function (index) {
                        $('#tableId thead tr:eq(1) th:eq(' + index + ') input').on('keyup change', function () {
                            table.column($(this).parent().index() + ':visible')
                            .search(this.value)
                            .draw();
                        });
                    } );
                    // add lightning class to search filter field with some bottom margin..  
                    $('div.dataTables_filter input').addClass('slds-input');
                    $('div.dataTables_filter input').css("marginBottom", "10px");
                }, 500);          
            }
        });
        $A.enqueueAction(action); 
    },
})