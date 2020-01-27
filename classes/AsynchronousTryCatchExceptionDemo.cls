public class AsynchronousTryCatchExceptionDemo {

    public static void raiseException(){
        try{
            System.debug(2/0);
        }catch(Exception ex){
            ErrorEvent__e errorEvent = new ErrorEvent__e();
            errorEvent.Error_Message__c = ex.getMessage();
            errorEvent.Source__c = 'AsynchronousTryCatchExceptionDemo';
            errorEvent.UserId__c = UserInfo.getUserId();

            ErrorMessage errorMessage = new ErrorMessage(errorEvent);

            IErrorLogger iErrorLogger = ErrorLogger.getErrorLoggerInstance();
            iErrorLogger.fireErrorEvent(errorMessage);
            iErrorLogger.flush();
        }
    }

}