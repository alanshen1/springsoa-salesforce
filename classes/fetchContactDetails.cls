/**
 * Created by spring2 on 18-11-2019.
 */

public class fetchContactDetails {

    @AuraEnabled
    public static list<Contact> fetchContactList(){
        return [select Id, name, Account.name, Email from contact limit 10];
    }
}