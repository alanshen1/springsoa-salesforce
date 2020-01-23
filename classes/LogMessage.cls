public class LogMessage {

    public ProcessType iProcessType;
    public Exception iException;
    public String errorMessage;
    public String source;
    public String stackTrace;
    public String payload;

    public enum ProcessType {
        CustomPlatformEvent,Batch,EmailHandler,Flow, Warning, Error
    }

    public LogMessage(){}
}