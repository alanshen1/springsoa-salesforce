@isTest
public class SandboxRefreshUpdateBatchTest {
    @testsetup
    public static void testSetup(){
        Contact contact = new Contact(LastName = 'Test-1',Email='test@testContact.com');
        insert contact;

        Lead lead = new Lead(LastName = 'Test-1',Email='test@testLead.com');
        insert lead;

        Case testCase = new Case(SuppliedEmail='test@testCaseSuppliedEmail.com');
        insert testCase;
    }

    @isTest
    public static void testBatch(){
        Test.startTest();

        Test.stopTest();
    }
}