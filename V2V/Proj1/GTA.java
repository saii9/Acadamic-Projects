/*
 * Course       : Cooperative Communicative vehicles
 * Assignment   : Java Project 1
 * Author       : Sundeep Innamuri - 004507888
 * File         : NmeaReader.java
 * Discription  : main file in the project
 * Written on   : 21 June 2016 
 */

import java.io.File;

public class GTA {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here

        String fileName = args[0];
        File f = new File(fileName);
        if (!f.exists()) {
          // file exist
            System.out.println("The file path is not valid");
            return;
        }
        GpsReader reader;
        //System.out.println(fileName.substring(fileName.length() - 4, fileName.length()));
       if (".csv".equals(fileName.substring(fileName.length() - 4, fileName.length()))){
            reader = new CsvReader(fileName);
       }  else if(".nmea".equals(fileName.substring(fileName.length() - 5, fileName.length()))){
            reader = new NmeaReader(fileName); 
       }else{
           System.out.println("Error : file types .csv and .nmea are only accepted");
           return;
       }
       reader.calculate_values(reader.readFile());
       reader.printValues();
    }
    
}
