/**
* cshah on : 03-12-2020
* */
public class OpportunityTriggerHandler {
    @TestVisible private static final String stageName = 'Closed Won';
    @TestVisible private static final String role = 'Family Member';

    public static void afterInsert(list<Opportunity> opportunity) {
        addContactRoles(opportunity, null);
    }

    public static void afterUpdate(list<Opportunity> opportunity, map<Id, Opportunity> oldMap) {
        addContactRoles(opportunity, oldMap);
    }

    @TestVisible
    private static map<Id, list<Id>> findAccountIdToContactIds(list<Opportunity> opportunity) {
        map<Id, list<Id>> accountIdToContactIds = new map<Id, list<Id>>();
        for (Opportunity opportunityObj : opportunity) {
            if (opportunityObj.StageName == stageName && opportunityObj.AccountId != null) {
                accountIdToContactIds.put(opportunityObj.AccountId, null);
            }
        }
        if (accountIdToContactIds != null) {
            for (Contact contact : [Select Id,accountId from Contact WHERE accountId IN:accountIdToContactIds.keySet()]) {
                if (accountIdToContactIds.containsKey(contact.AccountId)) {
                    List<Id> contactIds = accountIdToContactIds.get(contact.AccountId);
                    accountIdToContactIds.put(contact.AccountId, contactIds);
                } else {
                    accountIdToContactIds.put(contact.AccountId, new List<Id>{
                            contact.Id
                    });
                }
            }
        }
        return accountIdToContactIds;
    }

    public static void insertContactRoles(Opportunity opportunityObj,Id contactId) {
        list<OpportunityContactRole> opportunityContactRole = new list<OpportunityContactRole>();
                OpportunityContactRole opportunityContactRoleObj = new OpportunityContactRole();
                opportunityContactRoleObj.ContactId = contactId;
                opportunityContactRoleObj.OpportunityId = opportunityObj.Id;
                opportunityContactRoleObj.IsPrimary = true;
                opportunityContactRoleObj.Role = role;
                opportunityContactRole.add(opportunityContactRoleObj);
        try {
            insert opportunityContactRole;
        } catch (Exception exp) {
            System.debug('AddContactRolesHandler.addContactRolesInsert Exception : ' + exp);
        }
    }

    @TestVisible
    private static void addContactRoles(list<Opportunity> opportunity, map<Id, Opportunity> oldMap) {
        for (Opportunity opportunityObj : opportunity) {
            if (oldMap != null && opportunityObj.StageName != oldMap.get(opportunityObj.Id).StageName && opportunityObj.StageName == stageName && opportunityObj.AccountId != null) {
                /**
                * This logic is not final yet this is just prototype until we got which contact to add
                *
                **/
                Id contactId = findAccountIdToContactIds(opportunity).get(opportunityObj.AccountId)[0];
                insertContactRoles(opportunityObj, contactId);
            }
            else if(opportunityObj.StageName == stageName && opportunityObj.AccountId != null){
                /**
                * This logic is not final yet this is just prototype until we got which contact to add
                *
                **/
                Id contactId = findAccountIdToContactIds(opportunity).get(opportunityObj.AccountId)[0];
                insertContactRoles(opportunityObj, contactId);
            }
        }
    }
}