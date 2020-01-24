public interface IErrorLogger {

    void logMessage(LogMessage logMessage);
    void logMessages(List<LogMessage> logMessages);
    void flush();

}