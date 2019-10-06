/**
 * Created by chint on 10/4/2019.
 */

global without sharing class ExternalDataSourceProvider extends DataSource.Provider {

    override global List<DataSource.AuthenticationCapability> getAuthenticationCapabilities() {
        System.debug(' ExternalDataSourceProvider.getAuthenticationCapabilities ');
        List<DataSource.AuthenticationCapability> capabilities =  new List<DataSource.AuthenticationCapability> {
                DataSource.AuthenticationCapability.ANONYMOUS
        };
        System.debug(' ExternalDataSourceProvider.getAuthenticationCapabilities ' + JSON.serialize(capabilities) );
        return capabilities;
    }

    override global List<DataSource.Capability> getCapabilities() {
        System.debug(' ExternalDataSourceProvider.getCapabilities ');
        List<DataSource.Capability> capabilities = new List<DataSource.Capability> {
            DataSource.Capability.ROW_QUERY
        };
        System.debug(' ExternalDataSourceProvider.getCapabilities ' + JSON.serialize(capabilities) );
        return capabilities;
    }

    override global DataSource.Connection getConnection(DataSource.ConnectionParams connectionParams) {
        System.debug(' ExternalDataSourceProvider.getConnection connectionParams: ' + connectionParams);
        DataSource.Connection connection = new ExternalDataSourceConnection(connectionParams);
        System.debug(' ExternalDataSourceProvider.getConnection connection: ' + connection);
        return connection;
    }

}