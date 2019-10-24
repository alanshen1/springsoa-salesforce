public class SandboxRefreshDataCreationPlugin implements SandboxRefreshPlugin{
    public static final String REFERENCE = 'reference-';

    public void execute(SandboxRefreshTemplate sandboxRefreshTemplate){
        List<SandboxRefreshTemplate.SObjectRecord> sObjectRecords = sandboxRefreshTemplate.sObjectRecords;
        System.debug('SandboxRefreshDataCreationPlugin.execute sObjectRecords: ' + sObjectRecords);
        if(sObjectRecords!=null && sObjectRecords.size()>0){
            Map<String,Id> referenceToIdMap=new Map<String, Id>();
            for(SandboxRefreshTemplate.SObjectRecord sObjectRecord : sObjectRecords){
                try{
                    SObject obj = Schema.getGlobalDescribe().get(sObjectRecord.sObjectName).newSObject() ;
                    obj = populateByParameter(sObjectRecord.attributes,obj,referenceToIdMap);
                    insert obj;
                    if(sObjectRecord.reference!=null)
                        referenceToIdMap.put(sObjectRecord.reference,obj.id);
                }catch (Exception e){
                    System.debug('SandboxRefreshDataCreationPlugin.execute e: ' + e.getMessage());
                }
            }
        }
    }
    private static SObject populateByParameter(Map<String,String> fMap, SObject so,Map<String,String> referenceToIdMap) {
        System.debug('SandboxRefreshDataCreationPlugin.populateByParameter fMap: ' + JSON.serialize(fMap));
        System.debug('SandboxRefreshDataCreationPlugin.populateByParameter so: ' + JSON.serialize(so));
        System.debug('SandboxRefreshDataCreationPlugin.populateByParameter referenceToIdMap: ' + JSON.serialize(referenceToIdMap));

        Map<String,Schema.sObjectField> fieldMap=so.getSObjectType().getDescribe().fields.getMap();
        for(String key: fMap.KeySet()) {
            if(fMap.get(key).containsIgnoreCase(reference)){
                String referenceValue = fMap.get(key).substring(reference.length());
                String value = referenceToIdMap.get(referenceValue.trim());
                if(value!=null)
                    fMap.put(key,value);
            }
            if(key == 'RecordTypeName') {
                try {
                    so.put('RecordTypeId',so.getSObjectType().getDescribe().getRecordTypeInfosByName().get(fMap.get(key)).getRecordTypeId());
                }
                catch(Exception e) {
                    System.debug(e.getMessage());
                }
            }
            else if(key != 'Id' && key !='RecordType' && fieldMap.get(key.toLowerCase()) != NULL ) {
                //&& fieldMap.get(key.toLowerCase()).getDescribe().isUpdateable()
                try {
                    String fieldType=String.ValueOf(fieldMap.get(key.toLowerCase()).getDescribe().getType()).toLowerCase();
                    if(fieldType == 'currency' || fieldType == 'double' || fieldType == 'percent' || fieldType == 'decimal') {
                        so.put(key, double.valueOf(fMap.get(key)));
                    }
                    else if(fieldType == 'boolean') {
                        so.put(key, Boolean.valueOf(fMap.get(key)));
                    }
                    else if(fieldType == 'date') {
                        Date d=date.parse(fMap.get(key));
                        so.put(key,d );
                    }
                    else If(fieldType == 'datetime') {
                        DateTime dt=DateTime.parse(fMap.get(key));
                        so.put(key,dt);
                    }
                    else {
                        so.put(key,fMap.get(key));
                    }
                }
                catch(Exception e) {
                    System.debug('SandboxRefreshDataCreationPlugin.populateByParameter e: ' + e.getMessage());
                }
            }
        }
        return so;
    }
}