/**
 * Created by chint on 10/4/2019.
 */

public without sharing class ExternalDataService {

    private static ExternalDataService instance;

    private ExternalDataService() {
        System.debug(' ExternalDataService.ExternalDataService ');
    }

    public static ExternalDataService getInstance() {
        System.debug(' ExternalDataService.getInstance ');
        if( instance == null ) {
            instance = new ExternalDataService();
        }
        return instance;
    }

    public List<DataSource.Table> getTables() {
        System.debug(' ExternalDataService.getTables ');
        List<DataSource.Table> tables = new List<DataSource.Table> {
                getEmployeeTable(),
                getAddressTable() };
        System.debug(' ExternalDataService.getTables tables ' + JSON.serialize(tables) );
        return tables;
    }

    public List<Map<String, Object>> getData(DataSource.QueryContext context) {
        System.debug(' ExternalDataService.getData context ' + JSON.serialize(context) );
        return getEmployeeData(context);
    }

    private DataSource.Table getEmployeeTable() {
        List<DataSource.Column> columns = new List<DataSource.Column> {
                // get(name, label, description, isSortable, isFilterable, type, length, decimalPlaces)
                DataSource.Column.get( 'Employee_Id', 'Employee Id', 'Employee Identification Desc', false, false, DataSource.DataType.String_Short_Type, 0),
                DataSource.Column.indirectLookup( 'Account_Key', 'Account', 'Account_Key__c'),
                DataSource.Column.text('Employee_Name',255)
        };
        return DataSource.Table.get('Employee', 'Employee_Id', columns);
    }

    private List<Map<String, Object>> getEmployeeData(DataSource.QueryContext context) {
        List<Map<String,Object>> dataRows = new List<Map<String,Object>>();
        return dataRows;
    }

    private DataSource.Table getAddressTable() {
        List<DataSource.Column> columns = new List<DataSource.Column> {
                // get(name, label, description, isSortable, isFilterable, type, length, decimalPlaces)
                DataSource.Column.get( 'Address_Id', 'Address Id', 'Address Identification Desc', false, false, DataSource.DataType.String_Short_Type, 0),
                DataSource.Column.indirectLookup( 'Account_Key', 'Account', 'Account_Key__c'),
                DataSource.Column.text('Address_Name',255)
        };
        return DataSource.Table.get('Address', 'Address_Id', columns);
    }

    private List<Map<String, Object>> getAddressData(DataSource.QueryContext context) {
        List<Map<String,Object>> dataRows = new List<Map<String,Object>>();
        return dataRows;
    }


}