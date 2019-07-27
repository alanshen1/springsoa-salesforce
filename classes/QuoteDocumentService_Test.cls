/**
 * Created by Spring7 on 6/11/2019.
 */
@isTest
public with sharing class QuoteDocumentService_Test {
    @isTest
    public static void testGenerateDocument(){
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Contact cont = new Contact(LastName = 'Test Account');
        insert cont;
        Opportunity opp = new Opportunity(Name = 'Test Opp', StageName = 'Prospecting', CloseDate = System.today());
        insert opp;
        Quote quote = new Quote(Name = 'Test', OpportunityId = opp.Id);
        insert quote;

        Test.startTest();

        String attachmentId = QuoteDocumentService.generateDocument('<div> <b> Hello World </b></div>',quote.Id);

        Test.stopTest();
        System.assertEquals(true,attachmentId!=null);
    }
    
    @isTest
    public static void testQuoteDocument_5(){
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Contact cont = new Contact(LastName = 'Test Account');
        insert cont;
        Opportunity opp = new Opportunity(Name = 'Test Opp', StageName = 'Prospecting', CloseDate = System.today());
        insert opp;
        Quote quote = new Quote(Name = 'Test', OpportunityId = opp.Id);
        insert quote;
        
        Test.startTest();
        
        PageReference pageRef = Page.QuoteDocument_5;
        pageRef.getParameters().put('Id', quote.Id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController quoteController = new ApexPages.StandardController(quote);
        QuoteDocument_5 ace = new QuoteDocument_5(quoteController);        
        Test.stopTest();
    }
}