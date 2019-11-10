public class SandboxRefreshInvalidateEmailPlugin implements SandboxRefreshPlugin{
    public final static Integer BATCH_SIZE = 200;
    public String execute(SandboxRefreshTemplate sandboxRefreshTemplate){
        try {
            System.debug('SandboxRefreshInvalidateEmailPlugin.execute sandboxRefreshTemplate: ' + JSON.serialize(sandboxRefreshTemplate));
            for(SandboxRefreshTemplate.InvalidateEmailsObject invalidateEmailsObject : sandboxRefreshTemplate.inValidateEmailsObjects){
                String sObjectName = invalidateEmailsObject.sObjectName;
                List<String> emailFields = invalidateEmailsObject.emailFields.split(',');
                Database.executeBatch(new SandboxRefreshUpdateBatch(sObjectName, emailFields), BATCH_SIZE);
            }
        } catch(Exception e) {
            System.debug('SandboxRefreshInvalidateEmailPlugin.execute error ' + e.getMessage() + e.getStackTraceString() );
            return 'ERROR : ' + e.getMessage() + e.getStackTraceString();
        }
        return 'SandboxRefreshInvalidateEmailPlugin.execute executed successfully ';
    }
}