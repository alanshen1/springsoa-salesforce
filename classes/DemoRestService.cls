/**
 * Created by Chintan Shah on 12/27/2019.
 */

@RestResource(urlMapping='/DemoRestService/*')
global with sharing class DemoRestService {

    @HttpGet
    global static String doGet() {
        System.debug('DemoRestService.doGet currentUser ' + UserInfo.getUserName() );
        return [ select id from Account limit 1].Name;
    }

    @HttpPost
    global static String doPost(String name) {
        System.debug('DemoRestService.doPost currentUser ' + UserInfo.getUserName() + ' name ' + name );
        return name;
    }

}