@isTest
public class ErrorLoggerTest {

    @isTest
    public static void testLogMessageRaiseEvent(){
        AsynchronousTryCatchExceptionDemo.raiseException();
    }
	
    @isTest
    public static void testLogMessage(){
        SynchronousTryCatchExceptionDemo.raiseException();
    }
    
    @isTest
    public static void testLogMessageBatchApexErrorEvent(){
        insert new Account(Name = 'BatchExceptionAccount',CustomerPriority__c = 'Low');
        Database.executeBatch( new BatchExceptionDemo());
    }
    
    @isTest
    public static void testLogMessageInvocable(){
        List<ErrorMessage> errorMessages = new List<ErrorMessage>();
        ErrorMessage errorMessage = new ErrorMessage();
        try{
            Contact contact = new Contact(FirstName = 'Test');
            insert contact;
        }catch(Exception ex){
        	errorMessage = new ErrorMessage('InvocableMethod',ex);    
        }
        errorMessages.add(errorMessage);
        ErrorLogger.logMessage(errorMessages);
    }
    
    @isTest
    public static void testLogMessageEmailHandler(){
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        email.subject = 'Test';
        email.htmlBody = 'Test';
        ErrorMessage errorMessage = new ErrorMessage('Test',email);
        
        IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
        iErrorLogger.logMessage(errorMessage);
        iErrorLogger.flush();
    }
}