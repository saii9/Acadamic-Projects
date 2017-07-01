
import java.io.IOException;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author Sunny
 */
public class ICW {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException {
        // TODO code application logic here
        CsvReader cr = new CsvReader(args[0]);
        List<Parameters> veh = cr.readFile();
        if(veh == null) return;
        Collections.sort(veh, new ParameterComparator());
        cr.process_icw(veh);
    }
}
