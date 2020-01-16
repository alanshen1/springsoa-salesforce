/**
 * Created by rr245546 on 5/23/2017.
 */

public with sharing class PlatformCacheManager implements IPlatformCacheManager {

    private static final String StatisticsCachePartitionName = 'local.StatisticsCache';

    /** it will provide stats based on a key  **/
    public Statistics getStatistics(String key) {
        if( SystemSettings__c.getInstance('default').PlatformCacheMgrEnabled__c == true ) {
            Cache.OrgPartition statisticsPartition = getStatisticsPartition();
            if( statisticsPartition != null ) {
                return (Statistics) statisticsPartition.get( key );
            } else {
                System.debug( LoggingLevel.ERROR, 'Cache Partition ' + StatisticsCachePartitionName + ' Not found ' );
            }
        }
        return null;
    }

    /** stores the stats : note : it will be saved on transaction commmit, so ignore any exception */
    public void storeStatistics(String key, Statistics statistics) {
        if( SystemSettings__c.getInstance('default').PlatformCacheMgrEnabled__c == true ) {
            Cache.OrgPartition statisticsPartition = getStatisticsPartition();
            if( statisticsPartition != null ) {
                System.debug('statistics = '+statistics);
                statisticsPartition.put( key, statistics,  172800 );
            } else {
                System.debug( LoggingLevel.ERROR, 'Cache Partition ' + StatisticsCachePartitionName + ' Not found ' );
            }
        }
    }

    /**
     * get all stats from platform cache. will be used to store in database
     */
    public Map<String, Statistics> getAllStatistics() {
        if( SystemSettings__c.getInstance('default').PlatformCacheMgrEnabled__c == true ) {
            Cache.OrgPartition statisticsPartition = getStatisticsPartition();
            if( statisticsPartition != null ) {
                Set<String> keys = statisticsPartition.getKeys();
                System.debug( LoggingLevel.INFO,  'getAllStatistics keys ' + keys );
                if( keys != null && keys.size() > 0 ) {
                    Map<String, Statistics> statisticsMap = new Map<String, Statistics>();
                    for(String key: keys ) {
                        statisticsMap.put( key, (Statistics) statisticsPartition.get(key) );
                    }
                    return statisticsMap;
                }
            }
        }
        return null;
    }


    @TestVisible
    private Cache.OrgPartition getOrgPartition(String partitionName) {
        return Cache.Org.getPartition(partitionName);
    }

    @TestVisible
    private Cache.OrgPartition getStatisticsPartition() {
        Cache.OrgPartition statisticsPartition = getOrgPartition(StatisticsCachePartitionName);
        return statisticsPartition;
    }

    public void clearStatistics() {
        Cache.OrgPartition statisticsPartition = getStatisticsPartition();
        Map<String, Statistics> statisticsMap = getAllStatistics();
        if( statisticsMap != null ) {
            for(String key : statisticsMap.keySet() ) {
                statisticsPartition.remove(key);
            }
        }
    }
}