/**
 * Created by Spring7 on 9/19/2019.
 */

public class CloneComponentBaseController {
    @AuraEnabled
    public static sObject getRecord(Id recordId, String fieldSetName,String sObjectApiName){
        List<String> sObjectFields = new List<String>();
        sObjectFields.add('Id');
        sObjectFields.addAll(getFieldSetFields(sObjectApiName,fieldSetName));
        sObject sObjectRecord = Database.query('SELECT ' + String.join(sObjectFields, ', ') + ' FROM '+ sObjectApiName +' WHERE Id = :recordId');
        return sObjectRecord;
    }

    @TestVisible
    private static List<String> getFieldSetFields(String sObjectName, String fieldSetName) {
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