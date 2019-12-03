public class decryptExtension{
    public Contact rec{get;set;}
    public string key{get;set;}
    public id recordId{get;set;}

    public decryptExtension(ApexPages.StandardController sc){
        recordId = Apexpages.CurrentPage().getParameters().get('id');
        if(recordId !=null){
            rec = [SELECT Id, LastName FROM Contact WHERE Id =: recordId ];
        }
    }

    public PageReference decryptData(){
        if(!string.isBlank(key)){
            String decryptedData = EncryptAndDecryptHelper.processDecryption(rec.LastName, key );
            if(decryptedData != null){
                rec.LastName = decryptedData;
                update rec;
                PageReference pg = new PageReference('/'+rec.id);
                return pg;
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Invalid Key'));
            }
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please enter your key'));
        }
        return null;
    }
}