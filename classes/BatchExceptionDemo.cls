public class BatchExceptionDemo implements Database.Batchable<sObject>,Database.RaisesPlatformEvents {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        String name = 'BatchExceptionAccount';
        return Database.getQueryLocator('Select Id from Account where Name = :name');
    }

    public void execute(Database.BatchableContext BC,List<sObject> scope) {
        Account account = (Account) scope.get(0);
        System.debug('BatchExceptionDemo.execute account: ' + JSON.serialize(account));
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.FirstName = 'BatchError';
        insert contact;
    }

    public void finish(Database.BatchableContext BC) {

    }
}