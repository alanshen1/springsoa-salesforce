/**
 * Created by rr245546 on 5/12/2017.
 */

/**
  * this is service factory to provide instance of checkpoint manager
  * and other managers
 */

public with sharing class ServiceFactory {
    private static ServiceFactory instance;
    private ICheckpointManager checkpointManager;
	private IPlatformCacheManager platformCacheManager;
    private IStatisticsManager statisticsManager;
    private ILoggingManager loggingManager;

    /**
      * private constructor
     */
    private ServiceFactory() {

    }

    /**
      * standard singleton
     */
    public static ServiceFactory getInstance() {
        if( instance == null ) {
            instance = new ServiceFactory();
        }
        return instance;
    }

    /**
     * this method returns checkpoint manager instance
     */
    public ICheckpointManager getCheckpointManagerInstance() {
        if( checkpointManager == null ) {
            checkpointManager = new CheckpointManager();
        }
        return checkpointManager;
    }
    
     /**
     * this method returns platform cache manager instance
     */
    public IPlatformCacheManager getPlatformCacheManagerInstance() {
        if( platformCacheManager == null ) {
            platformCacheManager = new PlatformCacheManager();
        }
        return platformCacheManager;
    }


    /**
     * this method returns statistics manager instance
     */
    public IStatisticsManager getStatisticsManagerInstance() {
        if( statisticsManager == null ) {
            statisticsManager = new StatisticsManager();
        }
        return statisticsManager;
    }

    /**
     * this method returns logging manager instance
     */
    public ILoggingManager getLoggingManagerInstance() {
        if( loggingManager == null ) {
            loggingManager = new LoggingManager();
        }
        return loggingManager;
    }
}