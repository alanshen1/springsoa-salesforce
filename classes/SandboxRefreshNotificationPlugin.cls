public class SandboxRefreshNotificationPlugin implements SandboxRefreshPlugin{
    public static final String DEFAULT_EMAIL = 'cshah@forwardfinancing.com';
    public String execute(SandboxRefreshTemplate template){
        System.debug('SandboxRefreshNotificationPlugin.execute template: ' + JSON.serialize(template));
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        List<String> emailToBeSend = getEmailAddress(template);
        email.setToAddresses(emailToBeSend);
        email.setPlainTextBody('Sandbox Refresh is completed successfully, Batch is In-Progress.');
        email.setSubject('Sandbox refresh is completed.');
        try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        }catch(exception e){
            System.debug('SandboxRefreshNotificationPlugin.execute : ' + e.getMessage());
            return 'ERROR : ' + e.getMessage() + e.getStackTraceString();
        }
        return 'SandboxRefreshNotificationPlugin.execute executed successfully ';
    }

    @testVisible
    private static List<String> getEmailAddress(SandboxRefreshTemplate template){
        System.debug('SandboxRefreshNotificationPlugin.getEmailAddress template: ' + JSON.serialize(template));
        if(String.isNotBlank(template.notificationEmails)){
            return template.notificationEmails.split(',');
        }
        return new List<String>{DEFAULT_EMAIL};
    }
}