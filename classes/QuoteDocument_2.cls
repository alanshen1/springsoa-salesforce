/**
 * Created by Spring7 on 5/9/2019.
 */

public with sharing class QuoteDocument_2 {

    public string generatedText{get; set;}

    public QuoteDocument_2(){
        generatedText = getPDFContent();
    }

    @AuraEnabled
    public static String getPDFContent(){
        EmailTemplate et = [SELECT Id, Name,Markup, TemplateStyle, HtmlValue, Body FROM EmailTemplate where Id = '00X2E000003DZX2'];
        System.debug(et.Markup);
        String str = et.Markup.replaceAll('relatedTo','Quote');
        List<Messaging.RenderEmailTemplateBodyResult> resList =
                Messaging.renderEmailTemplate('0032E00002SpAKY','0Q02E000004ASGtSAO', new List<String>{et.Markup});
        System.debug(resList[0].getSuccess());
        System.debug(resList[0].getMergedBody());
        return resList[0].getMergedBody();
    }

    @AuraEnabled
    public static void sendMail(String recordId){

        EmailTemplate templateId = [Select id from EmailTemplate where Id = '00X2E000003DZX2'];
        List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateID(templateId.Id);
        mail.setWhatId(recordId);
        mail.setTargetObjectId('0032E00002SpAKYQA3');
        mail.setSaveAsActivity(false);
        List<String>  listEmailMembers = new List<String>();
        listEmailMembers.add('tapeshwar.kumar@springsoa.com');
        mail.setToAddresses(listEmailMembers);
        Messaging.SendEmailResult [] r1 = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
}