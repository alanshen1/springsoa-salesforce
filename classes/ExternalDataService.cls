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
        return DataSource.Table.get('Employee', 'ExternalId', columns);
    }

    private List<Map<String, Object>> getDummyData() {
        Map<String,Object> row1 = new Map<String,Object> {
                'ExternalId' => 'Emp1',
                'Name' => 'Chintan Shah',
                'EmployeeAccountKey' => 'ACN1'
        };
        Map<String,Object> row2 = new Map<String,Object> {
                'ExternalId' => 'Emp2',
                'Name' => 'Mark Twain',
                'EmployeeAccountKey' => 'ACN1'
        };
        Map<String,Object> row3 = new Map<String,Object> {
                'ExternalId' => 'Emp3',
                'Name' => 'John Doe',
                'EmployeeAccountKey' => 'ACN2'
        };
        List<Map<String,Object>> dataRows = new List<Map<String,Object>> { row1, row2, row3 };
        return dataRows;
    }

    private List<Map<String, Object>> getEmployeeData(DataSource.QueryContext context) {
        if( context.tableSelection != null && context.tableSelection.tableSelected == 'Employee' ) {
            DataSource.Filter filter = context.tableSelection.filter;
            System.debug(' getEmployeeData filter ' + filter );
            String url = '/hr/employees';
            if( filter != null ) {
                if( filter.columnName != null  && filter.columnValue != null ) {
                    url = '/hr/employee/' + filter.columnName + '/' + filter.columnValue;
                } else if( filter.subfilters != null && filter.subfilters.size() > 0 ) {
                    DataSource.Filter subFilter = filter.subfilters.get(0);
                    if( subFilter.columnName != null  && subFilter.columnValue != null ) {
                        url = '/hr/employee/' + subFilter.columnName + '/' + subFilter.columnValue;
                    }
                }
            }
            List<Map<String,Object>> response = httpGetCallout('HerokuBasicAuth', url);
            return response;
        }
        return new List<Map<String,Object>>();
    }

    public static List<Map<String,Object>> httpGetCallout(String namedCredentials, String url) {
        List<Map<String,Object>> returnEmployees = new List<Map<String,Object>>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + namedCredentials + url );
        request.setMethod('GET');
        System.debug(' httpGetCallout url ' + url );
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            System.debug(' response.getBody() ' + response.getBody() );
            List<Object> employees = (List<Object>) JSON.deserializeUntyped( response.getBody() );
            for(Object employee : employees ) {
                Map<String, Object> currentEmployee = ( Map<String, Object> ) ( employee );
                returnEmployees.add( currentEmployee );
            }
        }
        system.debug( ' ExternalDataService.httpGetCallout returnEmployees ' + returnEmployees  );
        return returnEmployees;
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
        return DataSource.Table.get('Address', 'ExternalId', columns);
    }

    private List<Map<String, Object>> getAddressData(DataSource.QueryContext context) {
        List<Map<String,Object>> dataRows = new List<Map<String,Object>>();
        return dataRows;
    }


}