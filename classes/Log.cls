public class Log {

    public ProcessType iprocessType;
    public Exception e;
    public String errorMessage;
    public List<Object> parameters;
    public String source;
    public String stackTrace;

    public enum ErrorType {
        NA, LIMITS, GENERIC, LAST_MODIFIED_BY_ERROR, CREATED_BY_ERROR
    }
    public enum ProcessType {
        NA, ActiveDisclosureFacade, Renewal, Warning, Error
    }

    public Log() {
        this.errorMessage = '';
    }

    public Log(ProcessType processType, Exception e, String errorMessage) {
        this.iprocessType = processType;
        this.e = e;
        this.errorMessage = errorMessage;
    }

    public Log(ProcessType processType, Exception e, String errorMessage,String source, String stackTrace) {
        this.iprocessType = processType;
        this.e = e;
        this.errorMessage = errorMessage;
        this.source = source;
        this.stackTrace = stackTrace;
    }

    public Log(ProcessType processType, Exception e, String errorMessage, Object parameter) {
        this.iprocessType = processType;
        this.e = e;
        this.errorMessage = errorMessage;
        this.parameters = new List<Object>();
        parameters.add(parameter);
    }

    public Log(ProcessType processType, Exception e, String errorMessage, Object parameter,String source, String stackTrace) {
        this.iprocessType = processType;
        this.e = e;
        this.errorMessage = errorMessage;
        this.parameters = new List<Object>();
        parameters.add(parameter);
        this.source = source;
        this.stackTrace = stackTrace;
    }

    public Log(ProcessType processType, Exception e, String errorMessage, List<Object> parameters) {
        this.iprocessType = processType;
        this.e = e;
        this.errorMessage = errorMessage;
        this.parameters = parameters;
    }

    public Log(ProcessType processType, Exception e, String errorMessage, List<Object> parameters,String source, String stackTrace) {
        this.iprocessType = processType;
        this.e = e;
        this.errorMessage = errorMessage;
        this.parameters = parameters;
        this.source = source;
        this.stackTrace = stackTrace;
    }

    public Log(ProcessType processType, Exception e) {
        this.iprocessType = processType;
        this.e = e;
        this.errorMessage = e.getMessage();
    }

    public Log(ProcessType processType, Exception e, String source, String stackTrace) {
        this.iprocessType = processType;
        this.e = e;
        this.errorMessage = e.getMessage();
        this.source = source;
        this.stackTrace = stackTrace;
    }
}