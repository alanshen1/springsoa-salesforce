/**
 * Created by chint on 10/4/2019.
 */

global without sharing class ExternalDataSourceConnection extends DataSource.Connection {

    private DataSource.ConnectionParams connectionInfo ;

    global ExternalDataSourceConnection(DataSource.ConnectionParams connectionInfo) {
        System.debug(' ExternalDataSourceConnection.ExternalDataSourceConnection connectionInfo: ' + JSON.serialize(connectionInfo));
        this.connectionInfo = connectionInfo;
    }

    override global List<DataSource.Table> sync() {
        System.debug(' ExternalDataSourceConnection.sync ');
        /*
        List<DataSource.Table> tables = ExternalDataService.getInstance().getTables();
        System.debug(' ExternalDataSourceConnection.sync tables ' + JSON.serialize(tables) );
         */
        List<DataSource.Table> tables = new List<DataSource.Table>();
        List<DataSource.Column> columns;
        columns = new List<DataSource.Column>();
        columns.add(DataSource.Column.text('Name', 255));
        columns.add(DataSource.Column.text('ExternalId', 255));
        columns.add(DataSource.Column.url('DisplayUrl'));
        tables.add(DataSource.Table.get('Sample', 'Title', columns));
        return tables;
    }

    override global DataSource.TableResult query(DataSource.QueryContext context) {
        try {
            System.debug(' ExternalDataSourceConnection.query context ' + JSON.serialize(context));
            DataSource.TableResult tableResult = DataSource.TableResult.get(context, ExternalDataService.getInstance().getData(context) );
            System.debug(' ExternalDataSourceConnection.query tableResult ' + JSON.serialize(tableResult));
            return tableResult;
        } catch (Exception currentException) {
            String message = currentException.getMessage() + currentException.getStackTraceString() ;
            System.debug(' ExternalDataSourceConnection.query exception : ' + message );
            throw new DataSource.DataSourceException(message);
        }
    }
}