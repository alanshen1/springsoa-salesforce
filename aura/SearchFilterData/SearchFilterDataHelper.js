({

    createTable: function(component,uid){
    debugger;
        var tableWrapper = $('#tableDiv');
        var tableData = component.get('v.lstOpp');
        var columns = [
            { "data": "accName", title: 'Account' },
            { "data": "con.LastName" , "defaultContent": "<i>Not set</i>", title: 'Contact'},
            { "data": "opp.Name", "defaultContent": "<i>Not set</i>", title: 'Opportunity'}
        ];
        tableWrapper.html($('<table id="example'+ uid +'" width="100%"><thead></thead></table>'));
        tableWrapper.find('#example'+uid).DataTable({
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
    }

});