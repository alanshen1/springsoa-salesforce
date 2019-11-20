/**
 * Created by spring4 on 20-11-2019.
 */

public class FederatedResultDisplay {
    public List<sObject> allRecordDetail { get; set; }

    public FederatedResultDisplay() {
        String recordIds = null;
        if(ApexPages.currentPage().getParameters() != null && ApexPages.currentPage().getParameters().get('ids') != null){
            recordIds = ApexPages.currentPage().getParameters().get('ids');
            preparingData(recordIds);
        }
    } 
    public FederatedResultDisplay(String recordIds) {
        preparingData(recordIds);
    }

    @AuraEnabled
    public static List<sObject> auraPreparingData(String strIds) {
        FederatedResultDisplay obj = new FederatedResultDisplay(strIds);
        return obj.allRecordDetail;
    }

    public void preparingData(String recordIds) {
        Map<String, set<Id>> idMap = new Map<String, set<Id>>();
        allRecordDetail = new List<sObject>();

        for (String str : recordIds.split(',')) {
            if (idMap.containsKey(str.substring(0, 3))) {
                idMap.get(str.substring(0, 3)).add(Id.valueOf(str));
            } else {
                idMap.put(str.substring(0, 3), new set<Id>{
                        Id.valueOf(str)
                });
            }
        }
        for (String prefix : idMap.keySet()) {
            Id firstId = new List<Id>(idMap.get(prefix)).get(0);
            String objName = firstId.getSObjectType().getDescribe().getName();
            Set<Id> ids = idMap.get(prefix);
            List<sObject> Obj1 = Database.query('Select Name,CreatedDate from ' + objName + ' where Id in :ids');
            allRecordDetail.addAll(Obj1);
        }
    }
}