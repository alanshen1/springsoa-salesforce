public class SandboxRefreshUpdateBatch implements Database.Batchable<sObject>{
    private String sObjectName;
    private List<String> emailFields;

    public SandboxRefreshUpdateBatch(String sObjectName,List<String> emailFields){
        this.sObjectName = sObjectName;
        this.emailFields = emailFields;
        System.debug('SandboxRefreshUpdateBatch.SandboxRefreshUpdateBatch sObjectName: ' +sObjectName);
        System.debug('SandboxRefreshUpdateBatch.SandboxRefreshUpdateBatch emailFields: ' +emailFields);
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id';
        for(String fieldName : emailFields){
            query += ', ' + fieldName;
        }
        query += ' FROM ' + sObjectName;
        System.debug('SandboxRefreshUpdateBatch.start query: ' + query);
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<sObject> sObjectRecords){
        System.debug('SandboxRefreshUpdateBatch.execute sObjectRecords: ' + JSON.serialize(sObjectRecords));
        for(sObject sObjectRecord : sObjectRecords){
            for(String fieldName : emailFields){
                if(sObjectRecord.get(fieldName) != null){
                    sObjectRecord.put(fieldName,sObjectRecord.get(fieldName)+'.invalid');
                }
            }
        }
        update sObjectRecords;
    }
    public void finish(Database.BatchableContext bc){}
}