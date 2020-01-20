public class SynchronousErrorHandlingDemo {
    public static void createContact(){
        try{
            Contact contact = new Contact();
            contact.FirstName = 'FirstName';
            insert contact;
        }catch(Exception ex){
            System.debug('SynchronousErrorHandlingDemo.createContact ex: ' + ex);
            ILoggingManager iloggingManager = ServiceFactory.getInstance().getLoggingManagerInstance();
            iloggingManager.logMessage(Log.ProcessType.Warning,ex);
        }
    }
}