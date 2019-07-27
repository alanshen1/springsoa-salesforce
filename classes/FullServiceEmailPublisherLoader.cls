/************************************* MODIFICATION LOG ********************************************************************************************
 * FullServiceEmailPublisherLoader
 *
 * DESCRIPTION : Handle Case Send Email Team Signature for GCM/GIM Users
 *
 *---------------------------------------------------------------------------------------------------------------------------------------------------
 * DEVELOPER                                    DATE                   REASON
 *---------------------------------------------------------------------------------------------------------------------------------------------------
 * Acumen Solutions                           02/05/2019            -  Added Class to handle Case Send Email Team Signature for GCM/GIM Users
 *
 */
global class FullServiceEmailPublisherLoader implements QuickAction.QuickActionDefaultsHandler {

    global FullServiceEmailPublisherLoader() {}

    global void onInitDefaults(QuickAction.QuickActionDefaults[] defaults) {
        system.debug(defaults);
        QuickAction.SendEmailQuickActionDefaults sendEmailDefaults = (QuickAction.SendEmailQuickActionDefaults) defaults.get(0);
        Id caseId;
        if (String.valueOf(sendEmailDefaults.getContextId()).substring(0, 3) == EmailMessage.sobjecttype.getDescribe().getKeyPrefix()) {
            EmailMessage email = [Select ParentId From EmailMessage Where Id =: sendEmailDefaults.getContextId()];
            caseId = email.ParentId;
        } else {
            caseId = sendEmailDefaults.getContextId();
        }
        system.debug(caseId);
        if (caseId != null) {
            Case c = [SELECT Team_Signature__c, Team_From_Address__c FROM Case WHERE Id =: caseId];
            system.debug(c);
            if (c.Team_Signature__c != null && c.Team_From_Address__c != null) {
                EmailMessage emailMessage = (EmailMessage) sendEmailDefaults.getTargetSObject();
                system.debug(emailMessage);
                emailMessage.HTMLBody = '<br/><br/><br/><br/>'+UserInfo.getName()+c.Team_Signature__c + '<img src="'+ System.Label.DFIN_Logo +'"/>' + ( emailMessage.HTMLBody == null ? '' : emailMessage.HTMLBody ) ;
                emailMessage.ValidatedFromAddress = c.Team_From_Address__c;
                emailMessage.FromAddress=null;
                emailMessage.FromName=null;
                emailMessage.CcAddress=null;
                emailMessage.BccAddress=null;
                sendEmailDefaults.setInsertTemplateBody(true);
                sendEmailDefaults.setIgnoreTemplateSubject(false);
            }
        }
    }
}