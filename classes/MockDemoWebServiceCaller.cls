/**
 * Created by Chintan Shah on 10/19/2019.
 */

public with sharing class MockDemoWebServiceCaller {

    public List<Map<String,Object>> httpGetCallout(String url) {
        List<Map<String,Object>> returnEmployees = new List<Map<String,Object>>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint( url );
        request.setMethod('GET');
        System.debug(' MockDemoWebServiceCaller.httpGetCallout url ' + url );
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            System.debug(' response.getBody() ' + response.getBody() );
            List<Object> employees = (List<Object>) JSON.deserializeUntyped( response.getBody() );
            for(Object employee : employees ) {
                Map<String, Object> currentEmployee = ( Map<String, Object> ) ( employee );
                returnEmployees.add( currentEmployee );
            }
        } else {
            throw new MockException( response.getStatusCode() + ' ' + response.getBody() );
        }
        system.debug( ' MockDemoWebServiceCaller.httpGetCallout returnEmployees ' + returnEmployees  );
        return returnEmployees;
    }

    public List<Map<String,Object>> getAllEmployees() {
        try {
            return httpGetCallout('https://basic-authentication-ws.herokuapp.com/hr/employees');
        } catch(Exception e) {
            throw new MockException(e);
        }
    }

    public List<Map<String,Object>> getEmployee(String column, String value) {
        try {
            return httpGetCallout('https://basic-authentication-ws.herokuapp.com/hr/employee/' + column + '/' + value );
        } catch(Exception e) {
            throw new MockException(e);
        }
    }


}