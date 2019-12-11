public class ActionForProcessBuilder {

    @InvocableMethod(label='LogRequest Do Action')
    public static void doAction(LogRequest[] requests) {
        System.debug('Its working');
    }

    public class LogRequest {
        @InvocableVariable(label='Record ID' required=true)
        public Id recordIdLogRequest;

        @InvocableVariable(label='Parent ID' required=true)
        public Id parentIdLogRequest;

        @InvocableVariable(label='Adjusted Due Date' required=false)
        public Date adjustedDueDateLogRequest;
    }
}