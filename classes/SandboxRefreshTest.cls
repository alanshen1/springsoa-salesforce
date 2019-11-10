@isTest
public class SandboxRefreshTest {
    private static final String PROFILE_NAME = 'System Administrator';

    @testSetup
    public static void testSetup(){
        Contact testContact = new Contact(LastName='Test-LastNameContact',Email='test@testcontact.com');
        Lead testLead = new Lead(LastName = 'Test-LastNameLead',Email='test@testlead.com',Company='Test-Company');
        Case testCase = new Case(SuppliedEmail='test@testcase.com');

        insert testContact;
        insert testLead;
        insert testCase;
    }

    @isTest
    public static void sandboxRefreshRunApexClassTest(){
        Test.startTest();
        SandboxRefresh.runApexClass('Test');
        Test.stopTest();
        List<Account> accounts = [Select Id from Account];
        List<Opportunity> opportunities = [Select Id from Opportunity];
        //List<Application__c> applications = [Select Id from Application__c];

        Contact testContact = [Select Id,Email from Contact Limit 1];
        Lead testLead = [Select Id,Email from Lead limit 1];
        Case testCase = [Select Id,SuppliedEmail from Case limit 1];

        System.assertEquals(3,accounts.size());
        System.assertEquals(2,opportunities.size());
        //System.assertEquals(2,applications.size());

        System.assert(testContact.Email!='test@testcontact.com.invalid');
        System.assertEquals('test@testlead.com.invalid',testLead.Email);
        System.assertEquals('test@testcase.com.invalid',testCase.SuppliedEmail);
    }

    @Istest
    public static void testSandboxPostCopyScript() {
        Test.startTest();
        Test.testSandboxPostCopyScript(new SandboxRefresh(), userInfo.getOrganizationId(), userInfo.getOrganizationId(), UserInfo.getUserName().substringAfterLast('.'));
        Test.stopTest();
    }
}