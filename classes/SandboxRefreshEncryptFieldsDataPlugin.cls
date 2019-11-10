public class SandboxRefreshEncryptFieldsDataPlugin implements SandboxRefreshPlugin {
    public final static Integer BATCH_SIZE = 200;
    public String execute(SandboxRefreshTemplate sandboxRefreshTemplate){
        try {
            System.debug('SandboxRefreshEncryptFieldsDataPlugin.execute sandboxRefreshTemplate: ' + JSON.serialize(sandboxRefreshTemplate));
            for(SandboxRefreshTemplate.EncryptFieldsData encryptFieldsData : sandboxRefreshTemplate.encryptFieldsData){
                String sObjectName = encryptFieldsData.sObjectName;
                List<SandboxRefreshTemplate.SObjectField> emailFields = encryptFieldsData.sObjectFields;
                Database.executeBatch(new SandboxRefreshEncryptFieldsDataBatch(sObjectName, emailFields), BATCH_SIZE);
            }
        } catch(Exception e) {
            System.debug('SandboxRefreshEncryptFieldsDataPlugin.execute error ' + e.getMessage() + e.getStackTraceString() );
            return 'ERROR : ' + e.getMessage() + e.getStackTraceString();
        }
        return 'SandboxRefreshEncryptFieldsDataPlugin.execute executed successfully ';
    }
}