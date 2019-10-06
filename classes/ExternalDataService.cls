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
        System.debug(' ExternalDataService.getData context ' + context );
        return getEmployeeData(context);
    }

    private DataSource.Table getEmployeeTable() {
        List<DataSource.Column> columns;
        columns = new List<DataSource.Column>();
        columns.add(DataSource.Column.text('ExternalId', 255));
        columns.add(DataSource.Column.text('Name', 255));
        columns.add(DataSource.Column.url('DisplayUrl'));
        columns.add(DataSource.Column.indirectLookup('EmployeeAccountKey', 'Account', 'Account_Key__c'));
        return DataSource.Table.get('Employee', 'Id', columns);
    }

    private List<Map<String, Object>> getEmployeeData(DataSource.QueryContext context) {
        List<Map<String,Object>> dataRows = new List<Map<String,Object>>();
        return dataRows;
    }

    private DataSource.Table getAddressTable() {
        DataSource.Table table = new DataSource.Table();
        List<DataSource.Column> columns;
        columns = new List<DataSource.Column>();
        columns.add(DataSource.Column.text('ExternalId', 255));
        columns.add(DataSource.Column.text('Street', 255));
        columns.add(DataSource.Column.text('ZipCode', 255));
        columns.add(DataSource.Column.url('DisplayUrl'));
        columns.add(DataSource.Column.indirectLookup('AddressAccountKey', 'Account', 'Account_Key__c'));
        return DataSource.Table.get('Address', 'Id', columns);
    }

    private List<Map<String, Object>> getAddressData(DataSource.QueryContext context) {
        List<Map<String,Object>> dataRows = new List<Map<String,Object>>();
        return dataRows;
    }


}