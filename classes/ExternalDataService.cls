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
        return null;
    }

    public List<Map<String, Object>> getData(DataSource.QueryContext context) {
        System.debug(' ExternalDataService.getData context ' + JSON.serialize(context) );
        return null;
    }
}