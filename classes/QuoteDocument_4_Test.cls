@isTest
public class QuoteDocument_4_Test {
    
    @isTest
    public static void testQuoteDocument4() {
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Contact cont = new Contact(LastName = 'Test Account');
        insert cont;
        Opportunity opp = new Opportunity(Name = 'Test Opp', StageName = 'Prospecting', CloseDate = System.today());
        insert opp;
        Quote quote = new Quote(Name = 'Test', OpportunityId = opp.Id);
        insert quote;
        
        Test.startTest();
        
        PageReference pageRef = Page.QuoteDocument_4;
        pageRef.getParameters().put('Id', quote.Id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController quoteController = new ApexPages.StandardController(quote);
        QuoteDocument_4 ace = new QuoteDocument_4(quoteController);
        
        Test.stopTest();
    }
    
    @isTest
    public static void test_SendEmail() {
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Opportunity opp = new Opportunity(Name = 'Test Opp', StageName = 'Prospecting', CloseDate = System.today());
        insert opp;
        Quote quote = new Quote(Name = 'Test', OpportunityId = opp.Id);
        insert quote;
        
        Test.startTest();
        QuoteDocument_4.sendMail(quote.Id);
        Test.stopTest();
        
        System.assertEquals([Select Id from Attachment].size(), 1, 'PDF does not saved properly');
    }
    
    @isTest
    public static void test_saveQuoteToOpportunity() {
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Opportunity opp = new Opportunity(Name = 'Test Opp', StageName = 'Prospecting', CloseDate = System.today());
        insert opp;
        Quote quote = new Quote(Name = 'Test', OpportunityId = opp.Id);
        insert quote;
        
        Test.startTest();
        QuoteDocument_4.saveQuoteToOpportunity(quote.Id);
        Test.stopTest();
        
        System.assertEquals([Select Id from Attachment].size(), 1, 'PDF does not saved properly');
    }
}