public interface IErrorLogger {

    void logMessage(ErrorMessage errorMessage);
    void logMessages(List<ErrorMessage> errorMessages);
    void flush();

}