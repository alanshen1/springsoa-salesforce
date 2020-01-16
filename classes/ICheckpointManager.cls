/**
 * Created by rr245546 on 5/12/2017.
 */

public interface ICheckpointManager {
    void checkpoint();
    void checkpoint(Object parameter);
    void checkpoint(List<Object> parameters);
    void checkpoint(String className, String methodName);
    void checkpoint(String className, String methodName, List<Object> parameters);
    String getCheckpointDetail();
}