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
            printContent(context);
            DataSource.TableResult tableResult = DataSource.TableResult.get(context, ExternalDataService.getInstance().getData(context) );
            System.debug(' ExternalDataSourceConnection.query tableResult ' + JSON.serialize(tableResult));
            return tableResult;
        } catch (Exception currentException) {
            String message = currentException.getMessage() + currentException.getStackTraceString() ;
            System.debug(' ExternalDataSourceConnection.query exception : ' + message );
            throw new DataSource.DataSourceException(message);
        }
    }

    public static void printContent(DataSource.QueryContext context) {
        System.debug(' ExternalDataSourceConnection.printContent queryMoreToken ' + context.queryMoreToken + ' tableSelected ' + context.tableSelection.tableSelected );
        DataSource.Filter filter = context.tableSelection.filter;
        List<DataSource.Order> orders = context.tableSelection.order;
        List<DataSource.ColumnSelection> columnsSelected = context.tableSelection.columnsSelected;
        if( filter != null ) {
            System.debug('ExternalDataSourceConnection.printContent filter columnName ' + filter.columnName + ' columnValue ' + filter.columnValue + ' subfilters ' + filter.subfilters + ' tableName ' + filter.tableName + ' type ' + filter.type );
        }
        if( orders != null ) {
            for(DataSource.Order order : orders ) {
                System.debug('ExternalDataSourceConnection.printContent order columnName ' + order.columnName  + ' tableName ' + order.tableName + ' direction ' + order.direction );
            }
        }
        if( columnsSelected != null ) {
            for(DataSource.ColumnSelection columnSelected : columnsSelected ) {
                System.debug('ExternalDataSourceConnection.printContent columnSelected columnName ' + columnSelected.columnName  + ' tableName ' + columnSelected.tableName + ' aggregation ' + columnSelected.aggregation );
            }
        }
    }
}