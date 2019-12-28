/**
 * Created by Chintan Shah on 12/27/2019.
 */

public with sharing class HttpService {

    @TestVisible
    private static String callout(String endPoint, String httpMethod, Map<String, String> headers, String body, Integer timeout) {
        Http http = new Http();
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setTimeout(timeout);
        httpRequest.setEndpoint(endPoint);
        httpRequest.setMethod(httpMethod);
        for(String key : headers.keySet() ) {
            httpRequest.setHeader(key, headers.get(key) );
        }
        httpRequest.setBody(body);
        System.debug('HttpService.callout request : ' + httpRequest);
        HttpResponse httpResponse = http.send(httpRequest);
        String responseBody = httpResponse.getBody();
        System.debug('HttpService.callout responseBody : ' + responseBody);
        return responseBody;
    }

    @TestVisible
    private static String getValueFromXMLString(string xmlString, string keyField){
        string valueFound = '';
        if( xmlString.contains('<' + keyField + '>') && xmlString.contains('</' + keyField + '>') ) {
            try{
                valueFound = xmlString.substring(xmlString.indexOf('<' + keyField + '>') + keyField.length() + 2, xmlString.indexOf('</' + keyField + '>'));
            } catch (exception e){
                System.debug('Error in getValueFromXMLString.  Details: ' + e.getMessage() + ' keyfield: ' + keyfield);
            }
        }
        return valueFound;
    }

    public static String getTokenNamedCredentials(String namedCredential, String version) {
        String body = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:partner.soap.sforce.com">'
                + '           <soapenv:Body> '
                + '              <urn:login> '
                + '                 <urn:username>{!$Credential.Username}</urn:username> '
                + '                 <urn:password>{!$Credential.Password}</urn:password> '
                + '              </urn:login> '
                + '           </soapenv:Body> '
                + '       </soapenv:Envelope>';
        String endPoint = 'callout:' + namedCredential + '/services/Soap/u/' + version ;
        Map<String, String> headers = new Map<String, String> {
            'SFDC_STACK_DEPTH' => '1',
            'SOAPAction' => 'DoesNotMatter',
            'Accept' => 'text/xml',
            'Content-type' => 'text/xml',
            'charset' => 'UTF-8'
        };
        String responseBody = callout(endPoint, 'POST', headers , body, 60000);
        System.debug('HttpService.getTokenNamedCredentials responseBody : ' + responseBody );
        String token = getValueFromXMLString( responseBody, 'sessionId');
        System.debug('HttpService.getTokenNamedCredentials token : ' + token );
        return token;
    }



}