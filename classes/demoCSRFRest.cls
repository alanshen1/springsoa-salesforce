/**
 * Created by spring4 on 26-11-2019.
 */
@RestResource(urlMapping='/demoCSRFRest/*')
global with sharing class demoCSRFRest {

    @HttpGet
    global static String doGet() {
        Account account = new Account();
        account.Name = 'Hacked' + System.currentTimeMillis();
        insert account;
        return account.Id;
    }

    @HttpPost
    global static String doPost(String name,
            String phone, String website) {
        Account account = new Account();
        account.Name = name;
        account.phone = phone;
        account.website = website;
        insert account;
        return account.Id;
    }
}