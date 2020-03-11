public class AddContactRolesHandler {
    
    @TestVisible private static final String stageName = 'Closed Won';
    @TestVisible private static final String role = 'Family Member';
    
    //Insert Method
    public static void addContactRolesInsert(list<Opportunity> opportunity) {
        map<Id,Id> accountIdToContactId = new map<Id,Id>();
        list<OpportunityContactRole> opportunityContactRole = new list<OpportunityContactRole>();
        for(Opportunity opportunityObj : opportunity) {
            if(opportunityObj.StageName == stageName && opportunityObj.AccountId != null) {
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
    
    //Update Method 
    public static void addContactRolesUpdate(list<Opportunity> opportunity, map<Id,Opportunity> oldMap) {
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