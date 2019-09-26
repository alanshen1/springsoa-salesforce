/**
 * Created by Spring7 on 9/19/2019.
 */

public without sharing class CloneComponentBaseController {
    @AuraEnabled
    public static sObject getRecord(Id recordId, String fieldSetName,String sObjectApiName){
        System.debug(' CloneComponentBaseController.getRecord recordId: ' + recordId);
        System.debug(' CloneComponentBaseController.getRecord fieldSetName: ' + fieldSetName);
        System.debug(' CloneComponentBaseController.getRecord sObjectApiName: ' + sObjectApiName);
        List<String> sObjectFields = new List<String>();
        sObject sObjectRecord;
        sObjectFields.add('Id');
        try{
            sObjectFields.addAll(getFieldSetFields(sObjectApiName,fieldSetName));
            sObjectRecord = Database.query('SELECT ' + String.join(sObjectFields, ', ') + ' FROM '+ sObjectApiName +' WHERE Id = :recordId');
        }catch(Exception expException){
            throw new AuraHandledException(expException.getMessage());
        }

        return sObjectRecord;
    }

    @TestVisible
    private static List<String> getFieldSetFields(String sObjectName, String fieldSetName) {
        System.debug(' CloneComponentBaseController.getFieldSetFields sObjectName: ' + sObjectName);
        System.debug(' CloneComponentBaseController.getFieldSetFields fieldSetName: ' + fieldSetName);
        List<String> sObjectFields = new List<String>();
        Schema.SObjectType objectType = Schema.getGlobalDescribe().get(sObjectName);
        Schema.DescribeSObjectResult objectDescribe = objectType.getDescribe();
        Map<String, Schema.FieldSet> fieldSetMap = objectDescribe.fieldSets.getMap();
        Schema.FieldSet fieldSet = fieldSetMap.get(fieldSetName);
        for (Schema.FieldSetMember field : fieldSet.getFields()) {
            sObjectFields.add(field.getFieldPath());
        }
        return sObjectFields;
    }
}