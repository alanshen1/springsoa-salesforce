({
    scriptsLoaded : function(component, event, helper) {
        console.log('Script loaded..');
    },
    
    doInit : function(component,event,helper){
            setTimeout(function(){
                var tableData = component.get('v.lstOpp');
                console.log(JSON.parse(JSON.stringify(tableData)));
                $('#tableId thead tr:eq(1) th').each( function () {
                    var title = $('#example thead tr:eq(0) th').eq( $(this).index() ).text();
                    $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
                } );
                var table = $('#tableId').DataTable({
                    orderCellsTop: true,
                    data: tableData,
                    "columns": [
                        { "data": "accName" },
                        { "data": "con.LastName" , "defaultContent": "<i>Not set</i>"},
                        { "data": "opp.Name", "defaultContent": "<i>Not set</i>"}
                    ]
                });
                table.columns().every( function (index) {
                    $('#tableId thead tr:eq(1) th:eq(' + index + ') input').on('keyup change', function () {
                        table.column($(this).parent().index() + ':visible')
                        .search(this.value)
                        .draw();
                    });
                } );
                $('div.dataTables_filter input').addClass('slds-input');
                $('div.dataTables_filter input').css("marginBottom", "10px");
            }, 500);
    },
})