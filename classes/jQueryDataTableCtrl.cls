public with sharing class jQueryDataTableCtrl {
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName) {
        system.debug('ObjectName-->' + ObjectName);
        String searchKey = searchKeyWord + '%';
        
        List < sObject > returnList = new List < sObject > ();
      
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5   
        String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';
        List < sObject > lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }

    @AuraEnabled
    public static List<FilterWrapper> fetchDataForFilters(String accountId, String accountStr,String contactId, String contactStr){
        System.debug('accountStr::'+accountStr);
        List<FilterWrapper> tableData = new List<FilterWrapper>();
        String query = 'SELECT FirstName, LastName,Account.Name,AccountId, (SELECT Name FROM Opportunities) FROM Contact';
        query += ' WHERE ';
        List<String> whereParts = new List<String>();
        if(String.isNotBlank(accountId)){
            whereParts.add( ' AccountId = :accountId');
        }
        if(String.isNotBlank(accountStr)){
            String accountStrTmp = '%' + accountStr + '%';
            whereParts.add(' Account.Name LIKE :accountStrTmp');
        }
        if(String.isNotBlank(contactId)){
            whereParts.add(' Id = :contactId');
        }
        if(String.isNotBlank(contactStr)){
            String contactStrTmp = '%' + contactStr + '%';
            whereParts.add(' FirstName LIKE :contactStrTmp OR LastName LIKE :contactStrTmp OR Email LIKE :contactStrTmp');
        }
        query += String.join(whereParts,' AND ');
        System.debug(JSON.serialize(Database.query(query)));
        for(Contact con : Database.query(query)){

            FilterWrapper fl;

            for(Opportunity opp : con.Opportunities){
                fl = new FilterWrapper();
                fl.accName = con.Account.Name;
                fl.con = con;
                fl.opp = opp;
                tableData.add(fl);
            }
            if(fl == null){
                fl = new FilterWrapper();
                fl.accName = con.Account.Name;
                fl.con = con;
                tableData.add(fl);
            }
        }
        System.debug('tableData-Size::'+tableData.size());
        return tableData;
    }

    public class FilterWrapper{

        @AuraEnabled public String accName{get;set;}
        @AuraEnabled public Contact con{get;set;}
        @AuraEnabled public Opportunity opp{get;set;}
    }
}