/**
 * Created by rr245546 on 6/20/2017.
 */

public interface ILoggingManager {
    /**
     * this method saves logs to logging table.
     */
    void logMessage(Log.ProcessType processType,Exception e);
    void logMessage(Log.ProcessType processType,Exception e, String source,String stackTrace);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage, String source,String stackTrace);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage, Object parameter);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage, Object parameter,String source,String stackTrace);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage, List<Object> parameters);
    void logMessage(Log.ProcessType processType,Exception e, String errorMessage, List<Object> parameters,String source,String stackTrace);

}