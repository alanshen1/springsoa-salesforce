/**
 * Created by rr245546 on 5/23/2017.
 */

/**
 * generic interface to work with platform cache
 * it should expose method to work with all partitions
 */
public interface IPlatformCacheManager {

    /** it will provide stats based on a key  **/
    Statistics getStatistics(String key);

    /** stores the stats : note : it will be saved on transaction commmit, so ignore any exception */
    void storeStatistics(String key, Statistics statistics);

    /**
     * get all stats from platform cache. will be used to store in database
     */
    Map<String, Statistics> getAllStatistics();
}