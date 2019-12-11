public with sharing class ActionForProcessBuilder {

    @InvocableMethod(label='Do Action')
    public static void doAction(Request[] requests) {
        System.debug('Its working');
    }

    public with sharing class Request {
        @InvocableVariable(label='Record ID' required=true)
        public Id recordId;

        @InvocableVariable(label='Parent ID' required=true)
        public Id parentId;

        @InvocableVariable(label='Adjusted Due Date' required=false)
        public Date adjustedDueDate;
    }
}