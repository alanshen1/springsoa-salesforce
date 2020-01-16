/**
 * Created by user on 6/2/2017.
 */

/**
 * this class stores stats
 */
public interface IStatisticsManager {
    void computeStatistics(Statistics.ResultState resultState, Statistics.Category category);
    void computeStatistics(Statistics.ResultState resultState, Statistics.Category category, Integer count);
}