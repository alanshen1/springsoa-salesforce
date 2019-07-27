/**
 * Created by spring2 on 10-06-2019.
 */

public with sharing class showAccountQuestionaries {

    Private Id accountID;
    public Account_Questionnaire__c accountQuestionaries { get; set; }
    public List<Account_Questionnaire__c> accountQuestionariesList { get; set; }

    public showAccountQuestionaries() {
        accountID = ApexPages.CurrentPage().getparameters().get('id');
        accountQuestionaries = new Account_Questionnaire__c();
    }

    public PageReference Save() {
        accountQuestionaries.Account__c = accountID;
        insert accountQuestionaries;
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Account Questionary Created Successfully. Thank you!'));

        accountQuestionariesList = [SELECT Id, Account__c, Send_Mail__c, Visibility__c FROM Account_Questionnaire__c WHERE Account__c =: accountID];

        List<Account> accounts = new List<Account>();
        if(!accountQuestionariesList.isEmpty()){
            for (Account_Questionnaire__c accountQuestionnaire : accountQuestionariesList) {
                if (accountQuestionnaire.Send_Mail__c == 'Yes') {
                    accounts.add(new Account(Id = accountQuestionnaire.Account__c, Questionnaire_Sent__c = true, Questionnaire_Received__c = true));
                }
                else {
                    accounts.add(new Account(Id = accountQuestionnaire.Account__c, Questionnaire_Received__c = true));
                }
            }
        }

        Map<Id,Account> AccountIdToAccountMap = new Map<Id,Account>();
        AccountIdToAccountMap.putall(accounts);
        if(AccountIdToAccountMap.size()>0){
            update AccountIdToAccountMap.values();
        }

        return null;
    }
}