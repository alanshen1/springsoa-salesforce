public class AttachQuoteDocument {
    private Id recordId; 
    public AttachQuoteDocument(ApexPages.StandardController controller){
        recordId = controller.getRecord().Id;
    }
    public void sendMail(){
        Quote quoteObj = [Select Id,OpportunityId from Quote where Id = :recordId];
        Messaging.SingleEmailMessage emailTobeSent = new Messaging.SingleEmailMessage();
        PageReference PDf =  Page.QuotePDF;
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
        listEmailMembers.add('tapeshwar.kumar@springsoa.com');
        emailTobeSent.setToAddresses(listEmailMembers);
        emailTobeSent.setSubject('Quote Document');
        emailTobeSent.setHtmlBody('Please find the attached quote document!');
        emailTobeSent.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); 
        Messaging.SendEmailResult [] r1 = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emailTobeSent});
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Quote Document successfully send!');
        ApexPages.addMessage(myMsg);
    }
}