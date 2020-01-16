/**
 * Created by rr245546 on 6/2/2017.
 */

public without sharing class Statistics {
    @TestVisible
    public enum ResultState { SUCCESS, FAIL, WARN}
    /**
     * Category is used in the key, so please don't add any special Char
     */
    @TestVisible
    public enum Category { ActiveDisclosureFacade, Renewal, ProfilingService, CheckpointWarning }


    public ResultState resultState;
    public Category category;
    public Integer totalCount = 0;
    public Integer totalSuccessCount = 0;
    public Integer totalFailureCount = 0;
    public Integer totalWarningCount = 0;
    public Integer averageSOQL = 0;
    public Integer averageSOSL = 0;
    public Integer averageCPU = 0;
    public Integer averageQueryRows = 0;
    public Integer maxSOQL = 0;
    public Integer maxSOSL = 0;
    public Integer maxCPU = 0;
    public Integer maxQueryRows = 0;

}