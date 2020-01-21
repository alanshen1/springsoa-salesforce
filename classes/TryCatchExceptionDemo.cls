public class TryCatchExceptionDemo {
    public static void raiseException(){
        try{
            System.debug(2/0);
        }catch(Exception ex){
            ILoggingManager iloggingManager = ServiceFactory.getInstance().getLoggingManagerInstance();
            iloggingManager.logMessage(Log.ProcessType.Error,ex,ex.getMessage());
        }
    }
}