public class AsynchronousTryCatchExceptionDemo {
    public static void raiseException(){
        try{
            System.debug(2/0);
        }catch(Exception ex){
            LoggingEvent__e loggingEvent = new LoggingEvent__e();
            loggingEvent.Error_Message__c = ex.getMessage();
            loggingEvent.Source__c = 'AsynchronousTryCatchExceptionDemo';
            loggingEvent.User__c = UserInfo.getUserId();

            ErrorMessage errorMessage = new ErrorMessage(loggingEvent);
            IErrorLogger iErrLogger = ErrorLogger.getErrorLoggerInstance();
            iErrLogger.fireLogEvent(errorMessage);
            iErrLogger.flush();

        }
    }
}