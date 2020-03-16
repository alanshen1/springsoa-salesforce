/**
 * Created by Chintan Shah on 12/20/2019.
 */

public without sharing class AccountTriggerHandler {

    Public static final String Default_Residential_Opportunity = 'Default Residential Opportunity';
    Public static final String Default_Commercial_Opportunity = 'Default Commercial Opportunity';
    Public static final String Stage_Prospecting = 'Prospecting';
    Public static final String AccountType_Prospect = 'Prospect';

    public static void afterInsert(List<Account> newAccounts) {
        System.debug(' AccountTriggerHandler.afterInsert newAccounts : ' + JSON.serialize(newAccounts));
        insertOpportunitiesOnAccount(newAccounts);
        System.debug(' AccountTriggerHandler.afterInsert insertOpportunities  ');
    }

    public static void afterUpdate(List<Account> newAccounts) {
        System.debug('AccountTriggerHandler.afterUpdate newAccounts : ' + JSON.serialize(newAccounts));

        List<Account> filterProspectAccounts = filterProspectAccounts(newAccounts);
        List<Account> accountsToInsertOpportunities = accountWithoutDefaultOpportunities(filterProspectAccounts);
    }

    public static List<Account> filterProspectAccounts(List<Account> newAccounts) {
        System.debug(' AccountTriggerHandler.filterProspectAccounts newAccounts : ' + JSON.serialize(newAccounts));

        List<Account> accounts = new List<Account>();
        for (Account account : newAccounts) {
            if (account.Type == AccountType_Prospect)
                accounts.add(account);
        }
        System.debug(' AccountTriggerHandler.filterProspectAccounts  accounts : ' + JSON.serialize(accounts));
        return accounts;
    }

    public static List<Account> accountWithoutDefaultOpportunities(List<Account> accounts) {

        Map<Id, Account> IdToAccountMap = new Map<Id, Account>(accounts);
        Set<Id> accountIds = new Set<Id>();
        for (Account account : accounts) {
            accountIds.add(account.Id);
        }
        System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities accountIds : ' + JSON.serialize(accountIds));

        List<Opportunity> Opportunities = [
                SELECT Id, Name, AccountId
                FROM Opportunity
                WHERE (Name = :Default_Residential_Opportunity
                OR Name = :Default_Commercial_Opportunity)
                AND AccountId IN:accountIds
        ];
        System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities Opportunities : ' + JSON.serialize(Opportunities));

        Set<Id> defaultOpportunityAccountIds = new Set<Id>();
        for (Opportunity opportunity : Opportunities) {
            defaultOpportunityAccountIds.add(opportunity.AccountId);
        }

        Map<Id, Account> IdToAccountsMap = new Map<Id, Account>(accounts);
        Map<Id, List<Opportunity>> IdToOpportunitiesMap = new Map<Id, List<Opportunity>>();
        Map<Id, List<Opportunity>> IdToWithoutDefaultOpportunitiesMap = new Map<Id, List<Opportunity>>();
        List<Opportunity> accountsWithOpportunities = new List<Opportunity>();
        for (Opportunity opportunity : Opportunities) {
            if (opportunity.Name == Default_Residential_Opportunity || opportunity.Name == Default_Commercial_Opportunity) {
                if (IdToOpportunitiesMap.containsKey(opportunity.AccountId)) {
                    accountsWithOpportunities = IdToOpportunitiesMap.get(opportunity.AccountId);
                    accountsWithOpportunities.add(opportunity);
                    IdToOpportunitiesMap.put(opportunity.AccountId, accountsWithOpportunities);
                } else {
                    accountsWithOpportunities.add(opportunity);
                    IdToOpportunitiesMap.put(opportunity.AccountId, accountsWithOpportunities);
                }
            } else {
                accountsWithOpportunities.add(opportunity);
                IdToWithoutDefaultOpportunitiesMap.put(opportunity.AccountId, accountsWithOpportunities);
            }
        }

        if (!IdToOpportunitiesMap.isEmpty()) {
            accountIds.removeAll(IdToOpportunitiesMap.keySet());
        }

        List<Account> accountsToCreateTask = new List<Account>();
        for (Id accountId : IdToWithoutDefaultOpportunitiesMap.keySet()) {
            if (IdToWithoutDefaultOpportunitiesMap.get(accountId).size() > 0) {
                accountsToCreateTask.add(IdToAccountMap.get(accountId));
            } else {
            }
        }
        if (!accountsToCreateTask.isEmpty()) {
            insertOpportunitiesOnAccount(accountsToCreateTask);
            sendMailToAccountOwner(accounts);
            System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities insertOpportunities  ');
        }

        Set<Id> accountWithDefaultOpportunities = new Set<Id>();
        Set<Id> accountWithoutDefaultOpportunities = new Set<Id>();
        Set<Id> accountWithoutResidentialOpportunities = new Set<Id>();
        Set<Id> accountWithoutCommercialOpportunities = new Set<Id>();
        if (opportunities.isEmpty()) {
            insertOpportunitiesOnAccount(accounts);
            sendMailToAccountOwner(accounts);
            System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities insertOpportunities  ');
        } else {
            for (Opportunity opportunity : opportunities) {
                if (opportunity.Name == Default_Residential_Opportunity || opportunity.Name == Default_Commercial_Opportunity) {
                    accountWithDefaultOpportunities.add(Opportunity.AccountId);
                } else {
                    accountWithoutDefaultOpportunities.add(Opportunity.AccountId);
                }
            }
            System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities accountWithDefaultOpportunities : ' + JSON.serialize(accountWithDefaultOpportunities));
            System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities accountWithoutDefaultOpportunities : ' + JSON.serialize(accountWithoutDefaultOpportunities));
        }


        if (accountWithDefaultOpportunities.isEmpty()) {
            accountIds.removeAll(accountWithDefaultOpportunities);
        } else {
            System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities else : ');
            List<Account> defaultOpportunityAccounts = [
                    SELECT Id, Name, (
                            SELECT Id
                            FROM Opportunities
                            WHERE (Name = :Default_Residential_Opportunity
                            OR Name = :Default_Commercial_Opportunity)
                    )
                    FROM Account
                    WHERE Id IN:accountWithDefaultOpportunities
            ];

            for (Account account : defaultOpportunityAccounts) {
                System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities Count of opportunities on account : ' + account.Opportunities.size());
                if (account.Opportunities.size() > 1) {
                    System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities Opportunity greater than 1 ');

                } else {
                    System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities Opportunity less than 1 ');

                    for (Id accountId : accountWithDefaultOpportunities) {
                        for (Opportunity opportunity : Opportunities) {
                            if (opportunity.Name != Default_Residential_Opportunity) {
                                accountWithoutResidentialOpportunities.add(Opportunity.AccountId);
                            } else if (opportunity.Name != Default_Commercial_Opportunity) {
                                accountWithoutCommercialOpportunities.add(Opportunity.AccountId);
                            }
                        }
                    }
                    System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities accountWithoutResidentialOpportunities : ' + JSON.serialize(accountWithoutResidentialOpportunities));
                    System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities accountWithoutCommercialOpportunities : ' + JSON.serialize(accountWithoutCommercialOpportunities));

                }
            }

        }
        System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities accountWithoutDefaultOpportunities : ' + JSON.serialize(accountIds));

        List<Account> accountToInsertResidentialOpportunities = new List<Account>();
        for (Id accId : accountWithoutResidentialOpportunities) {
            accountToInsertResidentialOpportunities.add(IdToAccountMap.get(accId));
            createResidentialOpportunity(accountToInsertResidentialOpportunities);
            System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities createResidentialOpportunity : ');
        }
        List<Account> accountToInsertCommercialOpportunities = new List<Account>();
        for (Id accId : accountWithoutCommercialOpportunities) {
            accountToInsertCommercialOpportunities.add(IdToAccountMap.get(accId));
            createCommercialOpportunity(accountToInsertCommercialOpportunities);
            System.debug(' AccountTriggerHandler.accountWithoutDefaultOpportunities createCommercialOpportunity : ');
        }

        List<Account> accountsToInsertOpportunities = new List<Account>();
        for (Id accId : accountWithDefaultOpportunities) {
            accountsToInsertOpportunities.add(IdToAccountMap.get(accId));
        }
        return accountsToInsertOpportunities;

    }

    public static void insertOpportunitiesOnAccount(List<Account> accounts) {
        System.debug(' AccountTriggerHandler.insertOpportunitiesOnAccount accounts : ' + JSON.serialize(accounts));

        List<Opportunity> opportunities = new List<Opportunity>();
        for (Account account : accounts) {

            Opportunity residentialOpportunity = new Opportunity();
            residentialOpportunity.AccountId = account.Id;
            residentialOpportunity.Name = Default_Residential_Opportunity;
            residentialOpportunity.StageName = Stage_Prospecting;
            residentialOpportunity.CloseDate = System.Today() + 5;
            opportunities.add(residentialOpportunity);

            Opportunity commercialOpportunity = new Opportunity();
            commercialOpportunity.AccountId = account.Id;
            commercialOpportunity.Name = Default_Commercial_Opportunity;
            commercialOpportunity.StageName = Stage_Prospecting;
            commercialOpportunity.CloseDate = System.Today() + 5;
            opportunities.add(commercialOpportunity);
        }

        try {
            insert opportunities;
            System.debug(' AccountTriggerHandler.insertOpportunitiesOnAccount Create Commercial And Residential Opportunity  : ' + JSON.serialize(opportunities));
        } catch (system.DmlException e) {
            system.debug(e);
        }
    }

    public static void createResidentialOpportunity(List<Account> accounts) {
        System.debug(' AccountTriggerHandler.createResidentialOpportunity accounts : ' + JSON.serialize(accounts));
        List<Opportunity> opportunities = new List<Opportunity>();
        for (Account account : accounts) {

            Opportunity residentialOpportunity = new Opportunity();
            residentialOpportunity.AccountId = account.Id;
            residentialOpportunity.Name = Default_Residential_Opportunity;
            residentialOpportunity.StageName = Stage_Prospecting;
            residentialOpportunity.CloseDate = System.Today() + 5;
            opportunities.add(residentialOpportunity);
        }

        try {
            insert opportunities;
            sendMailToAccountOwner(accounts);
            System.debug(' AccountTriggerHandler.createResidentialOpportunity Create Residential Opportunity  : ' + JSON.serialize(opportunities));
        } catch (system.DmlException e) {
            system.debug(e);
        }
    }
    public static void createCommercialOpportunity(List<Account> accounts) {
        System.debug(' AccountTriggerHandler.createCommercialOpportunity accounts : ' + JSON.serialize(accounts));
        List<Opportunity> opportunities = new List<Opportunity>();
        for (Account account : accounts) {
            Opportunity commercialOpportunity = new Opportunity();
            commercialOpportunity.AccountId = account.Id;
            commercialOpportunity.Name = Default_Commercial_Opportunity;
            commercialOpportunity.StageName = Stage_Prospecting;
            commercialOpportunity.CloseDate = System.Today() + 5;
            opportunities.add(commercialOpportunity);
        }

        try {
            insert opportunities;
            sendMailToAccountOwner(accounts);
            System.debug(' AccountTriggerHandler.createCommercialOpportunity Create Commercial Opportunity : ' + JSON.serialize(opportunities));
        } catch (system.DmlException e) {
            system.debug(e);
        }
    }

    public static void sendMailToAccountOwner(List<Account> accounts) {
        System.debug(' AccountTriggerHandler.sendMailToAccountOwner accounts : ' + JSON.serialize(accounts));

        Set<Id> accountOwnerIds = new Set<Id>();
        for (Account account : accounts) {
            accountOwnerIds.add(account.OwnerId);
        }
        System.debug(' AccountTriggerHandler.sendMailToAccountOwner accountOwnerIds : ' + JSON.serialize(accountOwnerIds));

        if (!accountOwnerIds.isEmpty()) {
            List<User> users = [SELECT Id, Email FROM User WHERE Id IN :accountOwnerIds];
            System.debug(' AccountTriggerHandler.sendMailToAccountOwner users : ' + JSON.serialize(users));
            List<String> toAddresses = new List<String>();
            if (users.size() > 0) {
                for (User u : users) {
                    toAddresses.add(u.Email);
                }

                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                for (Account account : accounts) {
                    mail.setToAddresses(toAddresses);
                    mail.setSubject('Opportunity is created on account');
                    mail.setPlainTextBody('Opportunities are altered or deleted from account');
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
                            mail
                    });
                }
            }
        }
    }
}