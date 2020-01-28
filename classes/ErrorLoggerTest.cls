@IsTest
public class ErrorLoggerTest {

    @IsTest
    public static void testLogMessageAsynchronousTryCatchExceptionDemo() {
        Test.startTest();
        AsynchronousTryCatchExceptionDemo.raiseException();
        Test.stopTest();

        Test.getEventBus().deliver();

        List<ErrorMessage__c> errorMessages = [SELECT Id FROM ErrorMessage__c];
        System.assertEquals(2, errorMessages.size());
    }

    @IsTest
    public static void testLogMessageSynchronousTryCatchExceptionDemo() {
        Test.startTest();
        SynchronousTryCatchExceptionDemo.raiseException();
        Test.stopTest();

        List<ErrorMessage__c> errorMessages = [SELECT Id FROM ErrorMessage__c];
        System.assertEquals(1, errorMessages.size());
    }

    @IsTest
    public static void testLogMessageBatchApexErrorEvent() {
        insert new Account(Name = 'BatchExceptionAccount');

        try {
            Test.startTest();
            Database.executeBatch(new BatchExceptionDemo());
            Test.getEventBus().deliver();
            Test.stopTest();
        } catch (Exception ex) {
        }

        Test.getEventBus().deliver();

        List<ErrorMessage__c> errorMessages = [SELECT Id FROM ErrorMessage__c];
        System.assertEquals(2, errorMessages.size());
    }

    @IsTest
    public static void testLogMessageInvocable() {
        List<ErrorMessage> errorMessages = new List<ErrorMessage>();
        ErrorMessage errorMessage = new ErrorMessage();

        Test.startTest();
        try {
            Contact contact = new Contact(FirstName = 'Test');
            insert contact;
        } catch (Exception ex) {
            errorMessage = new ErrorMessage('InvocableMethod', ex);
        }

        errorMessages.add(errorMessage);
        ErrorLogger.logMessage(errorMessages);
        Test.stopTest();

        List<ErrorMessage__c> errorMessagesResult = [SELECT Id FROM ErrorMessage__c];
        System.assertEquals(1, errorMessagesResult.size());
    }

    @IsTest
    public static void testLogMessageEmailHandler() {
        Test.startTest();
        Messaging.InboundEmail inboundEmail = new Messaging.InboundEmail() ;
        inboundEmail.subject = 'Test';
        inboundEmail.fromAddress = 'test@test.com';
        inboundEmail.plainTextBody = 'Test';

        ErrorMessageEmailHandler errorMessageEmailHandler = new ErrorMessageEmailHandler ();
        errorMessageEmailHandler.handleInboundEmail(inboundEmail, new Messaging.InboundEnvelope());
        Test.stopTest();

        List<ErrorMessage__c> errorMessages = [SELECT Id FROM ErrorMessage__c];
        System.assertEquals(1, errorMessages.size());
    }

    @IsTest
    public static void testLogMessageFlowExecutionErrorEvent() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(FirstName = 'Test-FirstName',LastName = 'Test-Lastame',Account = testAccount);
        insert testContact;
		System.debug('testLogMessageFlowExecutionErrorEvent Start');
        Test.startTest();
        FlowExecutionErrorEvent flowExecutionErrorEvent = new FlowExecutionErrorEvent();
        flowExecutionErrorEvent.ErrorMessage = 'Test';
        flowExecutionErrorEvent.UserId = UserInfo.getUserId();
        flowExecutionErrorEvent.FlowApiName = 'TestFlow';
        flowExecutionErrorEvent.ElementApiName = 'TestFlow';
        flowExecutionErrorEvent.ElementType = 'Test';
        flowExecutionErrorEvent.EventDate = System.today();
        flowExecutionErrorEvent.FlowExecutionStartDate = System.today();
        flowExecutionErrorEvent.FlowExecutionEndDate = System.today();
        flowExecutionErrorEvent.FlowVersionId = '1';
        flowExecutionErrorEvent.InterviewStartDate = System.today();
        flowExecutionErrorEvent.ProcessType = 'Flow';
        flowExecutionErrorEvent.RelatedRecordId = testContact.Id;
        flowExecutionErrorEvent.Username = 'Test';

        FlowExecutionErrorEventTriggerHandler.afterInsert(new List<FlowExecutionErrorEvent>{flowExecutionErrorEvent});
        Test.stopTest();

		System.debug('testLogMessageFlowExecutionErrorEvent End');
        List<ErrorMessage__c> errorMessages = [SELECT Id FROM ErrorMessage__c];
        System.assertEquals(1,errorMessages.size());
    }
}