/**
 * Created by Chintan Shah on 12/20/2019.
 */

public with sharing class AccountTriggerHandler {

    public static void afterUpdate(List<Account> oldAccounts, List<Account> newAccounts, Map<Id, Account> oldAccountsMap, Map<Id, Account> newAccountsMap) {
        System.debug('AccountTriggerHandler.afterUpdate newAccounts ' + JSON.serialize(newAccounts) );
    }


}