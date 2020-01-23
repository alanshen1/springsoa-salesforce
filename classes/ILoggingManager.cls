public interface ILoggingManager {
    void logMessage(Log.ProcessType processType,Exception e);
    void logMessage(Log.ProcessType processType,Exception e, String source,String stackTrace);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage, String source,String stackTrace);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage, Object parameter);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage, Object parameter,String source,String stackTrace);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage, List<Object> parameters);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage, List<Object> parameters,String source,String stackTrace);
    void logMessage(Log.ProcessType processType, String message,String errorType,String source) ;
}