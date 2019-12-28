/**
 * Created by Chintan Shah on 12/27/2019.
 */

public with sharing class DemoRestServiceProxyClient {

    public static String callDemoServiceOverHttp() {
        String token = HttpService.getTokenNamedCredentials('LocalEntry','47.0');
        String endPoint = Url.getSalesforceBaseUrl().toExternalForm() + '/services/apexrest/DemoRestService';
        String body = JSON.serialize( new Map<String, Object> {
            'name' => 'Chintan'
        } );
        Map<String, String> headers = new Map<String, String> {
            'Authorization' => 'OAuth ' + token,
            'Content-Type' => 'application/json'
        };
        System.debug(' DemoRestServiceProxyClient.callDemoServiceOverHttp  endPoint ' + endPoint + ' token ' + token + ' body ' + body );
        String response = HttpService.callout(endPoint,  'POST', headers, body, 60000);
        System.debug(' DemoRestServiceProxyClient.callDemoServiceOverHttp response ' + response );
        return response;
    }

}