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
        List<DataSource.Table> tables = ExternalDataService.getInstance().getTables();
        System.debug(' ExternalDataSourceConnection.sync tables ' + JSON.serialize(tables) );
        return tables;
    }

    override global DataSource.TableResult query(DataSource.QueryContext context) {
        try {
            System.debug(' ExternalDataSourceConnection.query context ' + context + ' ' + context.queryMoreToken + ' ' + JSON.serialize(context.tableSelection) );
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