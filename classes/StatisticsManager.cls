/**
 * Created by user on 6/2/2017.
 */

public without sharing class StatisticsManager implements IStatisticsManager{

    public void computeStatistics(Statistics.ResultState resultState, Statistics.Category category) {
        computeStatistics(resultState, category, 1);
    }

    public void computeStatistics(Statistics.ResultState resultState, Statistics.Category category, Integer count) {
        try {
            if( SystemSettings__c.getInstance('default') != null && SystemSettings__c.getInstance('default').StatisticsMgrEnabled__c != null && SystemSettings__c.getInstance('default').StatisticsMgrEnabled__c == true ) {
                String key = generateStatisticsKey(String.valueOf(category));
                calculateStatistics(key,count,String.valueOf(resultState),category);
            }
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR,'Error calling compute statistics ' + e.getMessage() );
        }
    }

    private void calculateStatistics(String key,Integer count,String resultState,Statistics.Category category){
        Statistics statistics = ServiceFactory.getInstance().getPlatformCacheManagerInstance().getStatistics(key);
        if( statistics == null ) {
            System.debug(  ServiceFactory.getInstance().getPlatformCacheManagerInstance().getAllStatistics() );
            statistics = new Statistics();
        }
        statistics.category=category;
        statistics.averageSOQL = ( (statistics.averageSOQL * statistics.totalCount) + Limits.getQueries() ) / (statistics.totalCount + 1);
        statistics.averageCPU = (( statistics.averageCPU * statistics.totalCount ) + Limits.getCpuTime() ) / (statistics.totalCount + 1);
        statistics.averageQueryRows = (( statistics.averageQueryRows * statistics.totalCount ) + Limits.getQueryRows() ) / (statistics.totalCount + 1);
        statistics.averageSOSL = (( statistics.averageSOSL * statistics.totalCount ) + Limits.getSoslQueries() ) / (statistics.totalCount + 1);
        if(statistics.maxSOQL<Limits.getQueries())
            statistics.maxSOQL=Limits.getQueries();
        if(statistics.maxCPU<Limits.getCpuTime())
            statistics.maxCPU=Limits.getCpuTime();
        if(statistics.maxQueryRows<Limits.getQueryRows())
            statistics.maxQueryRows=Limits.getQueryRows();
        if(statistics.maxSOSL<Limits.getSoslQueries())
            statistics.maxSOSL=Limits.getSoslQueries();
        statistics.totalCount+=count;
        if(resultState == 'SUCCESS'){
            statistics.totalSuccessCount+=count;
        }
        if(resultState == 'FAIL'){
            statistics.totalFailureCount+=count;
        }
        if(resultState == 'WARN'){
            statistics.totalWarningCount+=count;
        }
        System.debug('totalSuccessCount = '+statistics.totalSuccessCount);
        System.debug('totalFailureCount = '+statistics.totalFailureCount);
        System.debug('totalWarningCount = '+statistics.totalWarningCount);
        ServiceFactory.getInstance().getPlatformCacheManagerInstance().storeStatistics(key, statistics);
    }

    @TestVisible
    private void computeStatistics(String resultState, String category) {
        computeStatistics(resultState, category, 1);
    }

    //this method is written purely for test class
    @TestVisible
    private void computeStatistics(String resultState, String category, Integer count) {
        if( SystemSettings__c.getInstance('default') != null && SystemSettings__c.getInstance('default').StatisticsMgrEnabled__c != null && SystemSettings__c.getInstance('default').StatisticsMgrEnabled__c == true ) {
            String key = generateStatisticsKey(category);
            System.debug('key='+key);
            calculateStatistics(key,count,resultState,null);
        }
    }

    private static String generateStatisticsKey(String category) {
        String key = null;
        String day=null,month=null,year=null;
        if(System.now().day()<10){
            day='0'+System.now().day();
        }else{
            day=System.now().day()+'';
        }

        if(System.now().month()<10){
            month='0'+System.now().month();
        }else{
            month=System.now().month()+'';
        }
        year=System.now().year()+'';
        key=category+year+month+day;
        return key;
    }

}