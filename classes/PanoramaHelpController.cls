/**
 * Created by Spring7 on 7/10/2019.
 */

public with sharing class PanoramaHelpController {
    private static final String ACCOUNT_PREFIX = '001';
    private static final String OPPORTUNITY_PREFIX = '006';
    private static final String LEAD_PREFIX = '00Q';

    @AuraEnabled(cacheable=true)
    public static String getObjectName(Id currentRecordId) {
        String recordId = String.valueOf(currentRecordId);
        String objectName = '';
        if (currentRecordId != null && (recordId.startsWith(ACCOUNT_PREFIX) || recordId.startsWith(OPPORTUNITY_PREFIX) || recordId.startsWith(LEAD_PREFIX))) {
            objectName = currentRecordId.getSObjectType().getDescribe().getName();
            List<sObject> recordObject = Database.query('Select Id,Name from ' + objectName + ' Where Id =:currentRecordId');

            switch on recordId.substring(0, 3) {
                when '001' {
                    objectName += ' : ' + ((Account) recordObject[0]).Name;
                }
                when '006' {
                    objectName += ' : ' + ((Opportunity) recordObject[0]).Name;
                }
                when '00Q' {
                    objectName += ' : ' + ((Opportunity) recordObject[0]).Name;
                }
                when else {
                    objectName = 'Undefined';
                }
            }
        }else{
            objectName = 'Undefined';
        }
        return objectName ;
    }

    @AuraEnabled
    public static Id createCaseRecord(String relatedTo, String caseReason){
        Case caseObject = new Case(
                Reason=caseReason,
                Related_To__c = relatedTo
        );
        insert caseObject;
        return caseObject.Id;
    }
}