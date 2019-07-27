public class CloneOppotunityAndProducts {
    
    @AuraEnabled
    public static Opportunity cloneOpportunity(String oppoId, boolean isCloneWithProduct) {
        List<String> oppoApiNames = new List<String>();
        String ObjectName;
        
        try {
            Map<String, Object_Clone_Setting__c> objectCloneSettings = Object_Clone_Setting__c.getAll();
            Object_Clone_Setting__c OpportunityCloneSetting = objectCloneSettings.get('Opportunity');
            
            if (OpportunityCloneSetting != null) {
                ObjectName = OpportunityCloneSetting.Target_SObject_Name__c;
                if (OpportunityCloneSetting.Target_Field_API_Names__c != null && !String.isBlank(OpportunityCloneSetting.Target_Field_API_Names__c)) {
                    oppoApiNames = OpportunityCloneSetting.Target_Field_API_Names__c.split(',');
                }
            }
            
            System.debug('CloneOppotunityAndProducts.cloneOpportunity oppoApiNames' + oppoApiNames);
            
            String opportunityQuery = 'Select Name, CloseDate, StageName, Pricebook2Id, ' + String.join(oppoApiNames, ', ') + ' FROM ' + ObjectName +' Where Id = \'' + oppoId + '\'';
            
            System.debug('CloneOppotunityAndProducts.cloneOpportunity opportunityQuery' + opportunityQuery);
            
            Opportunity opportunity = Database.query(opportunityQuery);
            
            Map<String, Object> oppFieldsToValue = opportunity.getPopulatedFieldsAsMap();
            sObject cloneOpportunity = Schema.getGlobalDescribe().get(ObjectName).newSObject() ;
            for(String fieldApiName : oppFieldsToValue.keySet()){
                if(fieldApiName != 'Id'){
                    cloneOpportunity.put(fieldApiName, oppFieldsToValue.get(fieldApiName));  
                }
            }
            
            // cloneOpportunity.put('Name', cloneOpportunity.get('Name') + ' Clone');
            insert cloneOpportunity;
            
            System.debug('CloneOppotunityAndProducts.cloneOpportunity cloneOpportunity Id' + cloneOpportunity.Id);
            
            if (isCloneWithProduct) {
                cloneOpprtunityProducts(oppoId, cloneOpportunity.Id);
            }
            
            return (Opportunity)cloneOpportunity;
        } catch (Exception exp) {
            
        }
        
        return null;
    }
    
    public static void cloneOpprtunityProducts(String OpportunityId, String clonedOpportunityId) {
        List<String> oppoLineItemApiNames = new List<String>();
        String ObjectName;
        
        try {
            Map<String, Object_Clone_Setting__c> objectCloneSettings = Object_Clone_Setting__c.getAll();
            Object_Clone_Setting__c opportunityLineItemCloneSetting = objectCloneSettings.get('OpportunityLineItem');
            
            if (opportunityLineItemCloneSetting != null) {
                if (opportunityLineItemCloneSetting.Target_Field_API_Names__c != null && !String.isBlank(opportunityLineItemCloneSetting.Target_Field_API_Names__c)) {
                    oppoLineItemApiNames = opportunityLineItemCloneSetting.Target_Field_API_Names__c.split(',');
                }
                ObjectName = opportunityLineItemCloneSetting.Target_SObject_Name__c;
            }
            
            String opportunityLineItemQuery = 'Select OpportunityId, Product2Id, ' + String.join(oppoLineItemApiNames, ', ') + ' FROM ' + ObjectName +' Where OpportunityId = \'' + OpportunityId + '\'';
            
            System.debug('CloneOppotunityAndProducts.cloneOpprtunityProducts opportunityLineItemQuery' + opportunityLineItemQuery);
            
            
            List<OpportunityLineItem> opportunityLineItems = Database.query(opportunityLineItemQuery);
            System.debug('CloneOppotunityAndProducts.cloneOpprtunityProducts opportunityLineItem' + opportunityLineItems);
            
            List<sObject> cloneopportunityLineItems = new List<sObject>();
            for (OpportunityLineItem opportunityLineItem : opportunityLineItems) {
                Map<String, Object> oppFieldsToValue = opportunityLineItem.getPopulatedFieldsAsMap();
                sObject cloneopportunityLineItem = Schema.getGlobalDescribe().get(ObjectName).newSObject() ;
                for(String fieldApiName : oppFieldsToValue.keySet()){
                    if(fieldApiName != 'Id'){
                        cloneopportunityLineItem.put(fieldApiName, oppFieldsToValue.get(fieldApiName));  
                    }
                    
                    if(fieldApiName == 'OpportunityId'){
                        cloneopportunityLineItem.put(fieldApiName, clonedOpportunityId);  
                    }
                } 
                cloneopportunityLineItems.add(cloneopportunityLineItem);
            }
            
            System.debug('CloneOppotunityAndProducts.cloneOpprtunityProducts cloneopportunityLineItems' + cloneopportunityLineItems);
            
            if (cloneopportunityLineItems != null && cloneopportunityLineItems.size() > 0) {
                insert cloneopportunityLineItems;
            }
        } catch (Exception exp) {
            
        }
        
    }
}