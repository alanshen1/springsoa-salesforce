public interface IErrorLogger {

    void logMessage(ErrorMessage errorMessage);
    void logMessages(List<ErrorMessage> errorMessages);
    void fireLogEvent(ErrorMessage errorMessage);
    void fireLogEvents(List<ErrorMessage> errorMessages);
    void flush();

}