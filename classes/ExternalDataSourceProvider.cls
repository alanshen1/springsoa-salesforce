/**
 * Created by chint on 10/4/2019.
 */

global without sharing class ExternalDataSourceProvider extends DataSource.Provider {

    override global List<DataSource.AuthenticationCapability> getAuthenticationCapabilities() {
        System.debug(' ExternalDataSourceProvider.getAuthenticationCapabilities ');
        List<DataSource.AuthenticationCapability> capabilities =  new List<DataSource.AuthenticationCapability> {
                DataSource.AuthenticationCapability.ANONYMOUS,
                DataSource.AuthenticationCapability.OAUTH
        };
        return capabilities;
    }

    override global List<DataSource.Capability> getCapabilities() {
        System.debug(' ExternalDataSourceProvider.getCapabilities ');
        List<DataSource.Capability> capabilities = new List<DataSource.Capability> {
            DataSource.Capability.ROW_QUERY
        };
        return capabilities;
    }

    override global DataSource.Connection getConnection(DataSource.ConnectionParams connectionParams) {
        System.debug(' ExternalDataSourceProvider.getConnection connectionParams: ' + JSON.serialize(connectionParams));
        DataSource.Connection connection = new ExternalDataSourceConnection(connectionParams);
        System.debug(' ExternalDataSourceProvider.getConnection connection: ' + JSON.serialize(connection));
        return connection;
    }

}