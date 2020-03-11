trigger AddContactRoles on Opportunity (after insert, after update) {
    if(trigger.isAfter && trigger.isInsert){
        AddContactRolesHandler.addContactRolesInsert(trigger.new);
    }
    if(trigger.isAfter && trigger.isUpdate){
        AddContactRolesHandler.addContactRolesUpdate(trigger.new,trigger.oldMap);
    }
}