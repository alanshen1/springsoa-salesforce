public class SynchronousTryCatchExceptionDemo {
    public static void raiseException(){
        try{
            System.debug(2/0);
        }catch(Exception ex){
            ErrorMessage errorMessage = new ErrorMessage('SynchronousTryCatchExceptionDemo',ex);
            IErrorLogger iErrLogger = ErrorLogger.getErrorLoggerInstance();
            iErrLogger.logMessage(errorMessage);
            iErrLogger.flush();
        }
    }
}