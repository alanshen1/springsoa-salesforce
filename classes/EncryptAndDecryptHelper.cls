public class EncryptAndDecryptHelper {

    public static Blob cryptoKey;

    public static Map<Id,String> encryptKey = new Map<Id,String>();

    public static string expMsg;

    public static void processData(List<Contact> newRecords){

        List<messaging.SingleEmailMessage> mailmsg = new List<messaging.SingleEmailMessage>();

        List<Contact> financeList = new List<Contact>();

        Set<Id> recIds = new Set<Id>();

        if(trigger.isAfter && trigger.isInsert){
            for(Contact financeRec : newRecords){
                if(financeRec.LastName != null){
                    recIds.add(financeRec.Id);
                }
            }
            for(Contact financeRec : [SELECT Id,LastName FROM Contact WHERE Id IN: recIds]){
                financeRec.LastName = processEncryption(financeRec.LastName, financeRec.Id);
                financeList.add(financeRec);
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[]{userInfo.getUserEmail()});
                email.setSubject('The Encryption Key');
                email.setPlainTextBody('Hi'+' '+userInfo.getName()+','+'\r\n\n'+ 'The key for your record:'+' '+ encryptKey.get(financeRec.Id) + '\r\n'+ 'The record Id is:' + ' '+ financeRec.Id);
                mailmsg.add(email);
            }
            if(!financeList.isEmpty()){
                update financeList;
            }
            if(!mailmsg.isEmpty()){
                messaging.sendEmail(mailmsg);
            }
        }

    }

    public static string processEncryption(string name, Id recId){
        String key = 'U1oHp9/szWFkR8P3CDckSA==';
        encryptKey.put(recId, key);
        Blob data = Blob.valueOf(name);
        Blob encryptedData = Crypto.encryptWithManagedIV('AES128', EncodingUtil.base64Decode(key), data );
        string b64Data = EncodingUtil.base64Encode(encryptedData);
        return b64Data;
    }

    public static String processDecryption(string encryptedData, String key){
        System.debug(' EncryptAndDecryptHelper.processDecryption key: ' + JSON.serialize(key));
        String decryptedData;
        Blob data = EncodingUtil.base64Decode(encryptedData);
        String tempKey = EncodingUtil.base64Encode(EncodingUtil.base64Decode(Blob.valueOf(key).toString()));
        System.debug(' EncryptAndDecryptHelper.processDecryption tempKey: ' + JSON.serialize(tempKey));
        Blob privateKey = EncodingUtil.base64Decode(tempKey);
        try{
            Blob dataToDecrypt = Crypto.decryptWithManagedIV('AES128', privateKey, data);
            decryptedData = dataToDecrypt.toString();
        }catch(Exception e){
            expMsg = e.getMessage();
        }
        return (string.isEmpty(expMsg) ?  decryptedData :  null);
    }

}