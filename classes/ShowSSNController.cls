/**
 * Created by spring4 on 05-12-2019.
 */

public with sharing class ShowSSNController {
    @AuraEnabled
    public static String getSSN(String recordId, String key){
        String lastName = [SELECT LastName FROM Contact WHERE Id =:recordId].LastName;
        return EncryptAndDecryptHelper.processDecryption(lastName,key);
    }
}