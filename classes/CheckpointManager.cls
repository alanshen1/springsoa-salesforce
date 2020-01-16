/**
 creating this class without sharing to have all system level access
 e.g. Limit object, doesn't need to be constrained by User access.
 */


public without sharing class CheckpointManager implements ICheckpointManager {

    public static Boolean soqlWarningLogged = false;

    private class CallDetail {
        Datetime callerTime;
        String className,methodName;
        Double remainingSOQLPct=0.0,remainingQueryRowsPct=0.0,remainingCPUPct=0.0,remainingSOSLPct=0.0;

        List<Object> parameters;
        public CheckpointManager.CallDetail() {
            this.callerTime = System.now();
        }
        public CheckpointManager.CallDetail(List<Object> parameters) {
            this.callerTime = System.now();
            this.parameters = parameters;
        }
        public CheckpointManager.CallDetail(Object parameter) {
            this.callerTime = System.now();
            parameters = new List<Object>();
            this.parameters.add( parameter );
        }

        public CheckpointManager.CallDetail(String className, String methodName) {
            this.callerTime = System.now();
            this.className=className;
            this.methodName=methodName;
        }

        public CheckpointManager.CallDetail(String className, String methodName,List<Object> parameters) {
            this.callerTime = System.now();
            this.className=className;
            this.methodName=methodName;
            this.parameters = parameters;
        }


        public String getCheckpointDetail(){
            String checkpointDetail='Remaining SOQL= '+remainingSOQLPct+'%\n';
            checkpointDetail+='Remaining Query Rows= '+remainingQueryRowsPct+'%\n';
            checkpointDetail+='Remaining CPU= '+remainingCPUPct+'%\n';
            checkpointDetail+='Remaining SOSL= '+remainingSOSLPct+'%\n';
            checkpointDetail+='Caller Time = '+callerTime+'\n';
            if(parameters!=null)
                checkpointDetail+='Parameters = '+JSON.serialize(parameters)+'\n';
            if(className!=null)
                checkpointDetail+='Class Name = '+className+'\n';
            if(methodName!=null)
                checkpointDetail+='Method Name = '+methodName+'\n';
            checkpointDetail+='\n';
            return checkpointDetail;
        }
    }

    @TestVisible
    private List<CallDetail> callDetailStack = new List<CallDetail>();
    private CallDetail callDetail = null;

    /**
     * checkpoint using caller name
     */
    public void checkpoint() {
        if( isCheckpointManagerEnabled() ) {
            // if tracing enabled
            if( SystemSettings__c.getInstance('default').CheckptMgrTracingEnabled__c == true  ) {
                callDetail = new CallDetail();
                checkSOQLLimitException();
                checkQueryRowsLimitException();
                checkCPULimitException();
                checkSOSLLimitException();
                callDetailStack.add( callDetail );
            }

        }
    }

    /**
     * checkpoint using caller name and 1 param - usually in the begining and end, don't abuse it.
     */
    public void checkpoint(Object parameter) {
        if( isCheckpointManagerEnabled() ) {
            if( SystemSettings__c.getInstance('default').CheckptMgrTracingEnabled__c == true  ) {
                callDetail = new CallDetail(parameter);
                checkSOQLLimitException();
                checkQueryRowsLimitException();
                checkCPULimitException();
                checkSOSLLimitException();
                callDetailStack.add(callDetail);
            }

        }
    }

    /**
     * checkpoint using caller name and params - usually in the begining and end, don't abuse it.
     */
    public void checkpoint(List<Object> parameters) {
        if( isCheckpointManagerEnabled() ) {
            if( SystemSettings__c.getInstance('default').CheckptMgrTracingEnabled__c == true  ) {
                callDetail = new CallDetail(parameters);
                checkSOQLLimitException();
                checkQueryRowsLimitException();
                checkCPULimitException();
                checkSOSLLimitException();
                callDetailStack.add(callDetail);
            }

        }
    }

     /**
     * checkpoint using caller name, class name and method name
     */
    public void checkpoint(String className, String methodName) {
        if( isCheckpointManagerEnabled() ) {
            if( SystemSettings__c.getInstance('default').CheckptMgrTracingEnabled__c == true  ) {
                callDetail = new CallDetail(className,methodName);
                checkSOQLLimitException();
                checkQueryRowsLimitException();
                checkCPULimitException();
                checkSOSLLimitException();
                callDetailStack.add(callDetail);
            }

        }
    }


     /**
     * checkpoint using caller name, method name, class name and params - usually in the begining and end, don't abuse it.
     */
    public void checkpoint(String className, String methodName, List<Object> parameters) {
        if( isCheckpointManagerEnabled() ) {
            if( SystemSettings__c.getInstance('default').CheckptMgrTracingEnabled__c == true  ) {
                callDetail = new CallDetail(className, methodName, parameters);
                checkSOQLLimitException();
                checkQueryRowsLimitException();
                checkCPULimitException();
                checkSOSLLimitException();
                callDetailStack.add(callDetail);
            }

        }
    }



    /**
      returns formatted version of the call stack
     */
    public String getCheckpointDetail() {
        //return Json.serialize(callDetailStack);
        String checkpointDetail='';
        for(Integer i=0;i<callDetailStack.size();i++){
            checkpointDetail+='Call '+(i+1)+' :\n';
            checkpointDetail+=callDetailStack.get(i).getCheckpointDetail();

        }
        return checkpointDetail;
    }


    @TestVisible
    private void checkSOQLLimitException() {
        if( isCheckpointManagerEnabled() ) {
            Double soqlThresholdPercent = SystemSettings__c.getInstance('default').CheckptMgrRemainingSOQLThresholdPct__c;
            if( soqlThresholdPercent != null && soqlThresholdPercent > 0 ) {
                Double remainingSOQLPct = ( ( Limits.getLimitQueries() - Limits.getQueries() ) * 100 )  / (  Limits.getLimitQueries() );
                callDetail.remainingSOQLPct=remainingSOQLPct;
                System.debug(' callDetail.remainingSOQLPct = '+ callDetail.remainingSOQLPct);
                if( remainingSOQLPct <= soqlThresholdPercent ) {
                    System.debug(' throwing SOQL Exception ' );
                    callDetailStack.add( callDetail );
                    throw new CustomCheckpointException('SOQL Limit Exception because we only have ' + remainingSOQLPct + '% left.  ' );
                }

                checkAndLogWarning(remainingSOQLPct,'SOQL Limit Warning because we only have ' + remainingSOQLPct + '% left.');


            }
        }
    }

     @TestVisible
    private void checkQueryRowsLimitException() {
        if( isCheckpointManagerEnabled() ) {
            Double queryRowsThresholdPercent = SystemSettings__c.getInstance('default').CheckptMgrRemainingQueryRowsThresholdPct__c;
            if( queryRowsThresholdPercent != null && queryRowsThresholdPercent > 0 ) {
                Double remainingQueryRowsPct = ( ( Limits.getlimitqueryrows() - Limits.getqueryrows() ) * 100 )  / (  Limits.getlimitqueryrows() );
                callDetail.remainingQueryRowsPct=remainingQueryRowsPct;
                if( remainingQueryRowsPct <= queryRowsThresholdPercent ) {
                    callDetailStack.add( callDetail );
                    throw new CustomCheckpointException('Query Rows Limit Exception because we only have ' + remainingQueryRowsPct + '% left.  ' );
                }
                //checkAndLogWarning(remainingQueryRowsPct,'Query Rows Limit Warning because we only have ' + remainingQueryRowsPct + '% left.');
            }
        }
    }
    
    @TestVisible
    private void checkCPULimitException() {
        if( isCheckpointManagerEnabled() ) {
            Double cpuLimitThresholdPercent = SystemSettings__c.getInstance('default').CheckptMgrRemainingCPUThresholdPct__c;
            if( cpuLimitThresholdPercent != null && cpuLimitThresholdPercent > 0 ) {
                Double remainingCPUPct = ( ( Limits.getLimitCpuTime() - Limits.getCpuTime() ) * 100 )  / (  Limits.getLimitCpuTime() );
                callDetail.remainingCPUPct=remainingCPUPct;
                if( remainingCPUPct <= cpuLimitThresholdPercent ) {
                    callDetailStack.add( callDetail );
                    throw new CustomCheckpointException('CPU Limit Exception because we only have ' + remainingCPUPct + '% left.  ');
                }
                //checkAndLogWarning(remainingCPUPct,'CPU Limit Warning because we only have ' + remainingCPUPct + '% left.');
            }
        }
    }

    @TestVisible
    private void checkSOSLLimitException() {
        if (  isCheckpointManagerEnabled()  ) {
            Double soslThresholdPercent = SystemSettings__c.getInstance('default').CheckptMgrRemainingSOQLThresholdPct__c;
            if (soslThresholdPercent != null && soslThresholdPercent > 0) {
                Double remainingSOSLPct = ((Limits.getLimitSoslQueries() - Limits.getSoslQueries()) * 100) / (Limits.getLimitSoslQueries());
                callDetail.remainingSOSLPct=remainingSOSLPct;
                if (remainingSOSLPct <= soslThresholdPercent) {
                    callDetailStack.add( callDetail );
                    throw new CustomCheckpointException('SOSL queries Limit Exception because we only have ' + remainingSOSLPct + '% left.  ');
                }
                //checkAndLogWarning(remainingSOSLPct,'SOSL queries Warning because we only have ' + remainingSOSLPct + '% left.');
            }
        }
    }

    @TestVisible
    private static boolean isCheckpointManagerEnabled() {
        if (SystemSettings__c.getInstance('default') != null && SystemSettings__c.getInstance('default').CheckptMgrEnabled__c != null && SystemSettings__c.getInstance('default').CheckptMgrEnabled__c == true) {
            return true;
        }
        return false;
    }

    @TestVisible
    private static void checkAndLogWarning(Double remainingPercent,String message) {
        if (!soqlWarningLogged && SystemSettings__c.getInstance('default') != null && SystemSettings__c.getInstance('default').WarningEnabled__c != null && SystemSettings__c.getInstance('default').WarningEnabled__c == true && SystemSettings__c.getInstance('default').WarningThresholdPercent__c != null && SystemSettings__c.getInstance('default').WarningThresholdPercent__c >0) {
            if(remainingPercent <= SystemSettings__c.getInstance('default').WarningThresholdPercent__c){
                CustomCheckpointException checkpointException=new CustomCheckpointException(message);
                ServiceFactory.getInstance().getStatisticsManagerInstance().computeStatistics(Statistics.ResultState.WARN,Statistics.Category.CheckpointWarning);
                LoggingManager loggingManager=new LoggingManager();
                loggingManager.logMessage(Log.ProcessType.Warning,checkpointException,checkpointException.getMessage()+'\n\n'+checkpointException.getStackTraceString());
                soqlWarningLogged=true;
            }
        }
    }

}