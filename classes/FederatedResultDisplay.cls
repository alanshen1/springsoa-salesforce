/**
 * Created by spring4 on 20-11-2019.
 */

public class FederatedResultDisplay {
    public List<String> chosenId { get; set; }
    public Map<String, set<Id>> idMap { get; set; }
    public List<sObject> allRecordDetail { get; set; }
    public String linkId { get; set; }

    public FederatedResultDisplay() {
        idMap = new Map<String, set<Id>>();
        allRecordDetail = new List<sObject>();
        chosenId = ApexPages.currentPage().getParameters().get('ids').split(',');
        preparingData(chosenId);
    }
    public FederatedResultDisplay(Boolean temp) {
        idMap = new Map<String, set<Id>>();
        allRecordDetail = new List<sObject>();
    }

    @AuraEnabled
    public static List<sObject> auraPreparingData(String strIds) {
        Boolean isTemp = true;
        FederatedResultDisplay obj = new FederatedResultDisplay(isTemp);
        obj.preparingData(strIds.split(','));
        System.debug(obj.allRecordDetail);
        return obj.allRecordDetail;
    }

    public void preparingData(List<String> chosenId) {
        for (String str : chosenId) {
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