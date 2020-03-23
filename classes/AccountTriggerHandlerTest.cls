/**
 * Created by cshah on 16-03-2020.
 */

@IsTest
private class AccountTriggerHandlerTest {
    @testSetup static void testSetUp() {
        Account account = new Account();
        account.Name = 'Test Account';
        insert account;
    }

    @isTest static void insertOpportunitiesOnAccountTest() {
        List<Account> accounts = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];
        AccountTriggerHandler.afterInsert(accounts);
    }

    @isTest static void checkOpportunitiesOnProspectAccountTest() {
        List<Account> accounts = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];
        List<Account> updateAccounts = new List<Account>();
        for (Account account : accounts) {
            account.Type = 'Prospect';
            updateAccounts.add(account);
        }
        update updateAccounts;
        AccountTriggerHandler.afterUpdate(updateAccounts);
    }

    @isTest static void createResidentialOpportunitiesOnProspectAccountTest() {
        List<Account> accounts = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];
        List<Account> updateAccounts = new List<Account>();
        for (Account account : accounts) {
            account.Type = 'Prospect';
            updateAccounts.add(account);
        }
        List<Opportunity> opportunities = [SELECT Id, Name FROM Opportunity WHERE Name = 'Default Residential Opportunity' LIMIT 1];
        List<Opportunity> deleteOpportunities = new List<Opportunity>();
        for (Opportunity opportunity : opportunities) {
            if (opportunity.Name == 'Default Residential Opportunity') {
                deleteOpportunities.add(opportunity);
            }
        }
        delete deleteOpportunities;
        update updateAccounts;
        AccountTriggerHandler.afterUpdate(updateAccounts);
    }

    @isTest static void createCommercialOpportunitiesOnProspectAccountTest() {
        List<Account> accounts = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];
        List<Account> updateAccounts = new List<Account>();
        for (Account account : accounts) {
            account.Type = 'Prospect';
            updateAccounts.add(account);
        }
        List<Opportunity> opportunities = [SELECT Id, Name FROM Opportunity WHERE Name = 'Default Commercial Opportunity' LIMIT 1];
        List<Opportunity> deleteOpportunities = new List<Opportunity>();
        for (Opportunity opportunity : opportunities) {
            if (opportunity.Name == 'Default Commercial Opportunity') {
                deleteOpportunities.add(opportunity);
            }
        }
        delete deleteOpportunities;
        update updateAccounts;
        AccountTriggerHandler.afterUpdate(updateAccounts);
    }

    @isTest static void createBothOpportunitiesOnProspectAccountTest() {
        List<Account> accounts = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];
        List<Account> updateAccounts = new List<Account>();
        for (Account account : accounts) {
            account.Type = 'Prospect';
            updateAccounts.add(account);
        }
        List<Opportunity> opportunities = [SELECT Id, Name FROM Opportunity WHERE Name = 'Default Residential Opportunity' OR Name = 'Default Commercial Opportunity' LIMIT 2];
        delete opportunities;
        update updateAccounts;
        AccountTriggerHandler.afterUpdate(updateAccounts);
    }

    @isTest static void notToCreateOpportunitiesOnProspectAccountTest() {
        List<Account> accounts = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];
        List<Account> updateAccounts = new List<Account>();
        for (Account account : accounts) {
            account.Type = 'Prospect';
            updateAccounts.add(account);
        }
        update updateAccounts;
        AccountTriggerHandler.afterUpdate(updateAccounts);
    }
}