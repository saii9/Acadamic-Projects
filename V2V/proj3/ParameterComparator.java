
import java.util.Comparator;

/**
 *
 * @author Sunny
 */
public class ParameterComparator implements Comparator<Parameters> {
    public int compare(Parameters p1, Parameters p2) {
        return Double.valueOf(p1.getEpoch()).compareTo(Double.valueOf(p2.getEpoch()));
    }
}
