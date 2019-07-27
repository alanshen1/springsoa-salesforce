public class QuoteDocument_3 {
    public Quote qtObj {get; set;}
    public QuoteDocument_3(ApexPages.StandardController controller){
        Id recordId = controller.getRecord().Id;
        qtObj = [SELECT Id, Quote_Info__c,Information__c FROM Quote where Id = :recordId];
    }
    
    @AuraEnabled
    public static void sendMail(String recordId){
        Quote quoteObj = [Select Id,OpportunityId from Quote where Id = :recordId];
        Messaging.SingleEmailMessage emailTobeSent = new Messaging.SingleEmailMessage();
        PageReference PDf =  Page.QuoteDocument_3;
        PDf.getParameters().put('Id',recordId);
        PDf.setRedirect(true);

        Attachment attach = new Attachment();
        Blob b ;
        b = PDf.getContent();
        attach.Body = b;
        attach.Name = 'Quote_Document.pdf';
        attach.IsPrivate = false;
        attach.ParentId = quoteObj.OpportunityId;
        insert attach;

        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('QuoteDocument.PDF');
        efa.setBody(b);

        List<String>  listEmailMembers = new List<String>();
        listEmailMembers.add('salesforce@springsoa.com');
        emailTobeSent.setToAddresses(listEmailMembers);
        emailTobeSent.setSubject('Quote Document');
        emailTobeSent.setHtmlBody('Please find the attached quote document!');
        emailTobeSent.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        Messaging.SendEmailResult [] r1 = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emailTobeSent});
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Quote Document successfully send!');
        ApexPages.addMessage(myMsg);
    }
    
    @AuraEnabled
    public static void saveQuoteToOpportunity(String recordId){
        System.debug(recordId);
        Quote quoteObj = [Select Id,OpportunityId from Quote where Id = :recordId];
        PageReference PDf =  Page.QuoteDocument_3;
        PDf.getParameters().put('Id',recordId);
        PDf.setRedirect(true);

        Attachment attach = new Attachment();
        Blob b ;
        b = PDf.getContent();
        attach.Body = b;
        attach.Name = 'QuoteDocument_3.pdf';
        attach.IsPrivate = false;
        attach.ParentId = quoteObj.OpportunityId;
        insert attach;
    }
}