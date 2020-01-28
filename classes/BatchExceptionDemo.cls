public class BatchExceptionDemo implements Database.Batchable<sObject>, Database.RaisesPlatformEvents {

    private String accountName = 'BatchExceptionAccount';

    public Database.QueryLocator start(Database.BatchableContext BC) {
        Account account = new Account (Name = accountName);
        insert account;

        return Database.getQueryLocator('SELECT Id FROM Account WHERE Name = :accountName');
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope) {
        System.debug('BatchExceptionDemo.execute scope: ' + JSON.serialize(scope));

        List<Contact> contacts = new List<Contact>();
        for (Account account : (List<Account>) scope) {
            Contact contact = new Contact();
            contact.AccountId = account.Id;
            contact.FirstName = 'BatchError';
            contacts.add(contact);
        }

        insert contacts;
    }

    public void finish(Database.BatchableContext BC) {
    }

}