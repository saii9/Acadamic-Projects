/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.util.ArrayList;
/**
 *
 * @author Sunny
 */
public class CHPR {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException {
        // TODO code application logic here
        CsvReader cr = new CsvReader(args[0]);//("C:/Documents and Settings/Sunny/Documents/NetBeansProjects/ccvproj2/src/ccvproj2/input.txt");
        ArrayList<Parameters> veh = cr.readFile();
        if(veh == null) return;
        PathHistory ph = new PathHistory();
        ph.process_chpr(veh);
    
    }
    
}
