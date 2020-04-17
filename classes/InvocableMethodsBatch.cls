/**
 * Created by cshah on 17/04/20.
 */

public without sharing class InvocableMethodsBatch implements Database.Batchable<SObject> {

    private Id accountId;

    public InvocableMethodsBatch() {
        this.accountId = '0012E00002HsgtM';
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Rating FROM Account WHERE Id = :accountId');
    }

    public void execute(Database.BatchableContext bc, List<SObject> records) {
        for (Account account : (List<Account>) records) {
            account.Rating = 'Hot';
        }

        update records;
    }

    public void finish(Database.BatchableContext bc) {

    }

}