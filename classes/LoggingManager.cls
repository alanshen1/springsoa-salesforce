/**
 * Created by rr245546 on 6/20/2017.
 */

/**
 * adding without sharing as given user might not have access to logging table
 * however, still should be able to write/read log data
 */
public without sharing class LoggingManager implements ILoggingManager {

    @TestVisible
    private void logMessage(Log log) {
        /** check if logging manager is enable **/
        if( SystemSettings__c.getInstance('default') != null && SystemSettings__c.getInstance('default').LoggingMgrEnabled__c != null  && SystemSettings__c.getInstance('default').LoggingMgrEnabled__c == true ){
            String trackingHistory = ServiceFactory.getInstance().getCheckpointManagerInstance().getCheckpointDetail();
            String errorType='GENERIC';
            if(log.e!=null && log.e.getTypeName()!=null) {
                if(log.e.getTypeName().equalsIgnoreCase('CustomCheckpointException')){
                    errorType='LIMITS';
                }else if(log.e.getMessage().contains('LastModifiedBy ADUser does not exist in salesforce')){
                    errorType='LAST_MODIFIED_BY_ERROR';
                }else if(log.e.getMessage().contains('CreatedByADUser Name does not exist in salesforce')){
                    errorType='CREATED_BY_ERROR';
                }
            }

            String payload=null;
            log=checkHeapSize(log);
            if(log.parameters!=null){
                payload='';
                for(Integer i=0;i<log.parameters.size();i++){
                    payload+=JSON.serialize(log.parameters.get(i))+'\n';
                }
            }
            Log__c logS = new Log__c(
                    ErrorMessage__c=log.errorMessage,
                    trackingHistory__c=trackingHistory,
                    ErrorType__c=errorType,
                    ProcessType__c=String.valueOf(log.iprocessType),
                    User__c=UserInfo.getUserId(),
                    Payload__c=payload,
                    Source__c = String.isNotBlank(log.source)?log.source:'',
                    StackTrace__c  = String.isNotBlank(log.stackTrace)?log.stackTrace:''
            );
            insert logS;
        }
    }
    
    public void logMessage(Log.ProcessType processType, Exception ex) {
        try {
            Log log = new Log(processType, ex);
            logMessage( log );
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in logging manager ' + e.getMessage() );
        }
    }
    
    public void logMessage(Log.ProcessType processType, Exception ex, String source,String stackTrace) {
        try {
            Log log = new Log(processType, ex, source,stackTrace);
            logMessage( log );
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in logging manager ' + e.getMessage() );
        }
    }

    public void logMessage(Log.ProcessType processType, Exception ex, String errorMessage) {
        try {
            Log log = new Log(processType, ex, errorMessage);
            logMessage( log );
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in logging manager ' + e.getMessage() );
        }
    }

    public void logMessage(Log.ProcessType processType, Exception ex, String errorMessage,String source,String stackTrace) {
        try {
            Log log = new Log(processType, ex, errorMessage,source,stackTrace);
            logMessage( log );
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in logging manager ' + e.getMessage() );
        }
    }

    public void logMessage(Log.ProcessType processType, Exception ex, String errorMessage, Object parameter) {
        try {
            Log log = new Log(processType, ex, errorMessage,parameter);
            logMessage( log );
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in logging manager ' + e.getMessage() );
        }
    }

    public void logMessage(Log.ProcessType processType, Exception ex, String errorMessage, Object parameter,String source,String stackTrace) {
        try {
            Log log = new Log(processType, ex, errorMessage,parameter,source, stackTrace);
            logMessage( log );
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in logging manager ' + e.getMessage() );
        }
    }

    public void logMessage(Log.ProcessType processType, Exception ex, String errorMessage,List<Object> parameters) {
        try {
            Log log = new Log(processType, ex, errorMessage,parameters);
            logMessage( log );
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in logging manager ' + e.getMessage() );
        }
    }

    public void logMessage(Log.ProcessType processType, Exception ex, String errorMessage,List<Object> parameters,String source,String stackTrace) {
        try {
            Log log = new Log(processType, ex, errorMessage,parameters,source,stackTrace);
            logMessage( log );
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in logging manager ' + e.getMessage() );
        }
    }

    @TestVisible
    private Log checkHeapSize(Log log) {
        Double heapSizeThresholdPercent = SystemSettings__c.getInstance('default').LogMgrRemainingHeapSizeThresholdPct__c;
        if( heapSizeThresholdPercent != null && heapSizeThresholdPercent > 0 ) {
            Double remainingHeapSizePct = ( ( Limits.getLimitHeapSize() - Limits.getHeapSize() ) * 100 )  / (  Limits.getLimitHeapSize() );
            System.debug('Remaining Heap Size % = '+remainingHeapSizePct);
            if( remainingHeapSizePct <= heapSizeThresholdPercent ) {
                log.parameters=null;
            }
        }
        return log;
    }

    @TestVisible
    private static void logMessage(LogRequest logRequest) {
        if( SystemSettings__c.getInstance('default') != null && SystemSettings__c.getInstance('default').LoggingMgrEnabled__c != null  && SystemSettings__c.getInstance('default').LoggingMgrEnabled__c == true ){
            String trackingHistory = ServiceFactory.getInstance().getCheckpointManagerInstance().getCheckpointDetail();
            String errorType='GENERIC';
            String payload=null;
            Log__c logS = new Log__c(
                ErrorMessage__c=logRequest.errorMessage,
                trackingHistory__c=trackingHistory,
                ErrorType__c=errorType,
                ProcessType__c=logRequest.processType,
                User__c=UserInfo.getUserId(),
                Payload__c=logRequest.payload,
             	Source__c = String.isNotBlank(logRequest.source)?logRequest.source:'',
                StackTrace__c  = String.isNotBlank(logRequest.stackTrace)?logRequest.stackTrace:''
            );
            insert logS;
        }
    }

    @InvocableMethod(label='Log Message')
    public static void invocableLogMessage(LogRequest[] logRequests) {
        LogRequest logRequest;
        System.debug('LoggingManager.invocableLogMessage logRequests: ' + JSON.serialize(logRequests));
        if(!logRequests.isEmpty()){
            logRequest = logRequests[0];
        }else{
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in logging manager, Log request not found. ');
            return;
        }
        try {
            System.debug('LoggingManager.invocableLogMessage logRequest: ' + JSON.serialize(logRequest));
            logMessage(logRequest);
        } catch(Exception e) {
            System.debug('LoggingManager.invocableLogMessage e: ' + JSON.serialize(e)); 
            System.debug(LoggingLevel.ERROR, 'Error calling logMessage in logging manager ' + e.getMessage() );
        }
    }

    public class LogRequest {
        @InvocableVariable(required=true)
        public String processType;

        @InvocableVariable(required=true)
        public String errorMessage;

        @InvocableVariable(required=false)
        public String payload;
        
        @InvocableVariable(required=false)
        public String source;
        
        @InvocableVariable(required=false)
        public String stackTrace;
    }
}