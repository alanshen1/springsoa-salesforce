public class AsynchronousTryCatchExceptionDemo {
    public static void raiseException(){
        try{
            System.debug(2/0);
        }catch(Exception ex){
            LogEventManager.raiseEvent(ex.getMessage(),'Error','AsynchronousTryCatchExceptionDemo');
        }
    }
}