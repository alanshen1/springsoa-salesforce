/**
* Created by Spring7 on 5/15/2019.
*/
public class QuoteDocument_4 {
    
    public Id quoteId {get; set;}
    public String header1 {get; set;}
    public String header2 {get; set;}
    public String footer1 {get; set;}
    public QuoteDocument_4(ApexPages.StandardController controller){
        quoteId = controller.getId();
        List<String> resourceNames = new List<String>();
        resourceNames.add('QuoteToPDF_Header1');
        resourceNames.add('QuoteToPDF_Header2');
        resourceNames.add('QuoteToPDF_Footer1');
        
        List<StaticResource> resources = [SELECT Id, Body,Name FROM StaticResource WHERE Name in :resourceNames];
        
        for(StaticResource srObj : resources){
            switch on srObj.Name{
                when 'QuoteToPDF_Header1'{
                    header1 = srObj.Body.toString();
                }
                when 'QuoteToPDF_Header2'{
                    header2 = srObj.Body.toString();
                }
                when 'QuoteToPDF_Footer1'{
                    footer1 = srObj.Body.toString();
                }
            }
        }
    }
    public QuoteDocument_4(){
        
    }
    
    @AuraEnabled
    public static void sendMail(String recordId){
        Quote quoteObj = [Select Id,OpportunityId from Quote where Id = :recordId];
        Messaging.SingleEmailMessage emailTobeSent = new Messaging.SingleEmailMessage();
        PageReference PDf =  Page.QuoteDocument_4;
        PDf.getParameters().put('Id',recordId);
        PDf.setRedirect(true);
        
        Attachment attach = new Attachment();
        Blob b ;
        b = Test.isRunningTest() ? Blob.valueOf('MyString') : PDf.getContent();
        attach.Body = b;
        attach.Name = 'Quote_Document_4.pdf';
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
    }
    
    @AuraEnabled
    public static void saveQuoteToOpportunity(Id recordId){
        
        Quote quoteObj = [Select Id,OpportunityId from Quote where Id = :recordId];
        PageReference PDf =  Page.QuoteDocument_4;
        PDf.getParameters().put('Id',recordId);
        PDf.setRedirect(true);
        
        Attachment attach = new Attachment();
        Blob b ;
        b = Test.isRunningTest() ? Blob.valueOf('MyString') : PDf.getContent();
        attach.Body = b;
        attach.Name = 'QuoteDocument_6.pdf';
        attach.IsPrivate = false;
        attach.ParentId = quoteObj.OpportunityId;
        insert attach;
    }
    /* public Component.Apex.OutputPanel getFormPanelBody(){
Component.Apex.OutputPanel op = new Component.Apex.OutputPanel();

Component.Apex.OutputText opTextBody = new Component.Apex.OutputText();
PageReference htmlBodySR = PageReference.forResource('quoteToPDF', '/quoteToPDF/htmlBody.txt');

String srBody = htmlBodySR.getContent().toString();

List<Messaging.RenderEmailTemplateBodyResult> resList =
Messaging.renderEmailTemplate('0032E00002SpAKY','0Q02E000004ASGtSAO', new List<String>{srBody});
opTextBody.value=resList[0].getMergedBody();
opTextBody.escape = false;
op.childComponents.add(opTextBody);
return op;
}
public Component.Apex.OutputPanel getFormPanelHead(){
Component.Apex.OutputPanel op = new Component.Apex.OutputPanel();

Component.Apex.OutputText opTextHead = new Component.Apex.OutputText();
PageReference htmlHeadSR = PageReference.forResource('quoteToPDF', '/quoteToPDF/htmlHead.css');
String srBody = htmlHeadSR.getContent().toString();

opTextHead.value=srBody;
opTextHead.escape = false;
op.childComponents.add(opTextHead);
return op;
}
*/
    /*private String getContent (String resourceName){
StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = :resourceName LIMIT 1];
//return mergeFields(System.UserInfo.getUserId(), quoteId, sr.Body.toString());
System.debug(sr.Body.toString());
return sr.Body.toString();
}*/
    /*
public String getheader1(){
System.debug('Header-1');
return getContent('QuoteToPDF_Header1');
}
public String getheader2(){
System.debug('Header-2');
return getContent('QuoteToPDF_Header2');
}
public String getfooter1(){
System.debug('Header-3');
return getContent('QuoteToPDF_Footer1');
}
*/
    /*
private String mergeFields(String whoId, String whatid, String body) {
List<Messaging.RenderEmailTemplateBodyResult> resList =
Messaging.renderEmailTemplate(whoId, whatid, new List<String>{body});
return resList[0].getMergedBody();
}*/
}