({

    createTable: function(component,uid){
    debugger;
        var tableWrapper = $('#tableDiv');
        var tableData = component.get('v.lstOpp');
        var columns = [
            { "data": "accName", title: 'Account', "defaultContent": "<i>Not set</i>" },
            { "data": "con.LastName" , "defaultContent": "<i>Not set</i>", title: 'Contact'},
            { "data": "opp.Name", "defaultContent": "<i>Not set</i>", title: 'Opportunity'}
        ];
        tableWrapper.html($('<table id="example'+ uid +'" width="100%"><thead></thead></table>'));
        var table = tableWrapper.find('#example'+uid).DataTable({
            data: tableData,
            columns: columns,
            retrieve: true,
            destroy: true,
            responsive: true,
            "lengthMenu": [
                [10, 25, 50, -1],
                [10, 25, 50, "All"]
            ]
        });
        tableWrapper.find('#example'+uid+' thead').append('<tr><th>Account</th><th>Contact</th><th>Opportunity</th></tr>');
        tableWrapper.find('#example'+uid+' thead tr:eq(1) th').each( function () {
            var title = $('#example'+uid+' thead tr:eq(0) th').eq( $(this).index() ).text();
            $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
        } );

        table.columns().every( function (index) {
            tableWrapper.find('#example'+uid+' thead tr:eq(1) th:eq(' + index + ') input').on('keyup change', function () {
                table.column($(this).parent().index() + ':visible')
                    .search(this.value)
                    .draw();
            });
        } );
        $('div.dataTables_filter input').addClass('slds-input');
        $('div.dataTables_filter input').css("marginBottom", "10px");
    }

});