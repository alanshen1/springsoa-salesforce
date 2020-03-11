public class OpportunityTriggerHandler {
@TestVisible private static final String stageName = 'Closed Won';
    @TestVisible private static final String role = 'Family Member';
	
    /**
     *     public static afterUpdate -> addContactRolesUpdate, afterInsert _> insert
     *      update find oppy where there was change -> insert
     * 
     * 
     *      private Map<Id, List<Id>> findAccountIdToContactIds( ..List of )
     * */

    
    //Insert Method
    public static void afterInsert(list<Opportunity> opportunity) {
        map<Id,Id> accountIdToContactId = new map<Id,Id>();
        list<OpportunityContactRole> opportunityContactRole = new list<OpportunityContactRole>();
        for(Opportunity opportunityObj : opportunity) {
            if(opportunityObj.StageName == stageName && opportunityObj.AccountId != null) {
                accountIdToContactId.put(opportunityObj.AccountId,null);
            }
        }//1 method
        if(accountIdToContactId != null) {
            for(Contact contact : [Select Id,accountId from Contact WHERE accountId IN: accountIdToContactId.keySet()]) {
                if(accountIdToContactId.containsKey(contact.AccountId)) {
                    accountIdToContactId.put(contact.AccountId,contact.Id);
                }
                
            }// 2 method - list 3 method
            for(Opportunity opportunityObj : opportunity) {
                if(opportunityObj.StageName == stageName && opportunityObj.AccountId != null) {
                    OpportunityContactRole opportunityContactRoleObj = new OpportunityContactRole();
                    opportunityContactRoleObj.ContactId = accountIdToContactId.get(opportunityObj.AccountId);
                    opportunityContactRoleObj.OpportunityId = opportunityObj.Id;
                    opportunityContactRoleObj.IsPrimary = true;
                    opportunityContactRoleObj.Role = role;
                    opportunityContactRole.add(opportunityContactRoleObj);
                }
            }
            try {
                insert opportunityContactRole;
            }
            catch(Exception exp) {
                System.debug('AddContactRolesHandler.addContactRolesInsert Exception : ' + exp);
            }
        }
    }
    
    //Update Method 
    public static void afterUpdate(list<Opportunity> opportunity, map<Id,Opportunity> oldMap) {
        map<Id,Id> accountIdToContactId = new map<Id,Id>();
        list<OpportunityContactRole> opportunityContactRole = new list<OpportunityContactRole>();
        for(Opportunity OpportunityObj : opportunity) {
            if(OpportunityObj.StageName != oldMap.get(OpportunityObj.Id).stageName && OpportunityObj.StageName == stageName && opportunityObj.AccountId != null) {
                accountIdToContactId.put(opportunityObj.AccountId,null);
            }
        }
        if(accountIdToContactId != null) {
            for(Contact contact : [Select Id,accountId from Contact WHERE accountId IN: accountIdToContactId.keySet()]) {
                if(accountIdToContactId.containsKey(contact.AccountId)) {
                    accountIdToContactId.put(contact.AccountId,contact.Id);
                }
                
            }
            for(Opportunity opportunityObj : opportunity) {
                if(opportunityObj.StageName == stageName && opportunityObj.AccountId != null) {
                    OpportunityContactRole opportunityContactRoleObj = new OpportunityContactRole();
                    opportunityContactRoleObj.ContactId = accountIdToContactId.get(opportunityObj.AccountId);
                    opportunityContactRoleObj.OpportunityId = opportunityObj.Id;
                    opportunityContactRoleObj.IsPrimary = true;
                    opportunityContactRoleObj.Role = role;
                    opportunityContactRole.add(opportunityContactRoleObj);
                }
            }
            try {
                insert opportunityContactRole;
            }
            catch(Exception exp) {
                System.debug('AddContactRolesHandler.addContactRolesInsert Exception : ' + exp);
            }
        }
    }
}