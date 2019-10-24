public class SandboxRefreshInvalidateEmailPlugin implements SandboxRefreshPlugin{
    public final static Integer BATCH_SIZE = 200;
    public void execute(SandboxRefreshTemplate sandboxRefreshTemplate){
        System.debug('SandboxRefreshInvalidateEmailPlugin.execute sandboxRefreshTemplate: ' + JSON.serialize(sandboxRefreshTemplate));
        for(SandboxRefreshTemplate.InvalidateEmailsObject invalidateEmailsObject : sandboxRefreshTemplate.inValidateEmailsObjects){
            String sObjectName = invalidateEmailsObject.sObjectName;
            List<String> emailFields = invalidateEmailsObject.emailFields.split(',');
            Database.executeBatch(new SandboxRefreshUpdateBatch(sObjectName, emailFields), BATCH_SIZE);
        }
    }
}