/**
 * Created by Chintan Shah on 4/26/2018.
 */

public without sharing class NotificationUtility {

    /**
    * This method sends email based on configured email template id and any email address that is provided in to, cc, bcc.
    *
    * whatId would be used for template replacement
    * orgWideEmailFrom would be used for from email and display name
    * logActivity will log the activity on the record.
    *
    * @param subject
    * @param templateApiName
    * @param to
    * @param cc
    * @param bcc
    * @param whatId
    * @param orgWideEmailFrom
    * @param logActivity
    *
    * @return
    */
    public static boolean sendMail(String subject, String templateApiName, List<String> to, List<String> cc, List<String> bcc, Id whatId, Id orgWideEmailFrom, Boolean logActivity ) {
        System.debug('NotificationUtility.sendMail subject ' + subject + ' templateApiName ' + templateApiName + ' to ' + to + ' cc ' + cc + ' bcc ' + bcc + ' whatId ' + whatId + ' orgWideEmailFrom ' + orgWideEmailFrom + ' logActivity ' + logActivity );
        Boolean emailSentSuccessfully = false;

        Id templateId = [select id, name from EmailTemplate where developername = : templateApiName].id;
        System.debug(' NotificationUtility.sendEmail templateId : ' + templateId);

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setOrgWideEmailAddressId( orgWideEmailFrom );
        email.setWhatId( whatId );
        email.setTemplateId( templateId );
        email.setToAddresses( to );
        email.setCcAddresses( cc );
        email.setBccAddresses( bcc );
        email.setSaveAsActivity(logActivity);

        email.setTargetObjectId( [ select id from Contact limit 1].id );
        //This method would make sure email will not be sent to user
        email.setTreatTargetObjectAsRecipient(false);

        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        if (results !=null && results.size() > 0 ) {
            if (results[0].success) {
                System.debug('NotificationUtility.sendMail The email was sent successfully to ' + to + ' ' + cc + ' ' + bcc );
                emailSentSuccessfully = true;
            } else {
                System.debug('NotificationUtility.sendMail The email failed to send: ' + results[0].errors[0].message);
            }
        }

        return emailSentSuccessfully;
    }

    /**
    * This is legacy method which will send email based on custom body and custom list of recipients
    *
    * @param subject
    * @param body
    * @param recipients
    * @param isHtml
    */
    public static void sendMail(String subject, String body, List<String> recipients, boolean isHtml) {
        try {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toAddresses = recipients;
            message.optOutPolicy = 'FILTER';
            message.subject = subject;
            if( isHtml ) {
                message.htmlBody = body;
            } else {
                message.plainTextBody = body;
            }
            Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            if (results[0].success) {
                System.debug(LoggingLevel.INFO, 'NotificationUtility.sendMail The email was sent successfully . to ' + recipients + ' subject ' + subject );
            } else {
                System.debug(LoggingLevel.ERROR, 'NotificationUtility.sendMail The email failed to send: ' + results[0].errors[0].message + ' to ' + recipients + ' subject ' + subject  );
            }
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR, 'NotificationUtility.sendMail The email failed to send: ' + ' to ' + recipients + ' subject ' + subject + ' body ' + body );
            System.debug( e.getMessage()  + '\n' + e.getStackTraceString() );
        }
    }
}