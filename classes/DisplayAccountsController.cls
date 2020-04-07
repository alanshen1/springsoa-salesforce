/**
 * Created by Spring7 on 4/7/2020.
 */

public without sharing class DisplayAccountsController {

    @AuraEnabled
    public static List<Account> getAllAccounts(){
        return [Select Id,Name,Phone,Rating,Website,CreatedDate from Account order by CreatedDate];
    }
}