public interface IErrorLogger {

    void logMessage(ErrorMessage errorMessage);
    void logMessages(List<ErrorMessage> errorMessages);

    void fireErrorEvent(ErrorMessage errorMessage);
    void fireErrorEvents(List<ErrorMessage> errorMessages);
    
    void flush();

}