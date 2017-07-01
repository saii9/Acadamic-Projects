
/*
 * Course       : Cooperative Communicative vehicles
 * Assignment   : Java Project 1
 * Author       : Sundeep Innamuri - 004507888
 * File         : CsvReader.java
 * Discription  : to read .csv files
 * Written on   : 21 June 2016 
 */

    import java.io.BufferedReader;
    import java.io.FileReader;
    import java.io.FileNotFoundException;
    import java.io.IOException;
    import java.text.ParseException;
    import java.text.SimpleDateFormat;
    import java.util.ArrayList;
    import java.util.Calendar;
    import java.util.Date;
    import java.util.GregorianCalendar;
    import java.util.List;

    /**
     *
     * @author Sunny
     */
    public class CsvReader extends GpsReader{
        CsvReader(String filePath){
            super(filePath);
        }

        @Override
        public ArrayList<Parameters> readFile(){
            FileReader fileReader = null;
            List<Parameters> veh = new ArrayList<Parameters>();
            try {
                fileReader = new FileReader(filePath);
                try {
                    BufferedReader bufferedReader = new BufferedReader(fileReader);
                    String line;
                    int lineCount = 0;
                    while ((line = bufferedReader.readLine()) != null) {
                        lineCount++;
                        String splitz[] = line.split(",");                        
                        double epoch = Double.parseDouble(splitz[0]);
                        double longitude = Double.parseDouble(splitz[2]);
                        double lattitude = Double.parseDouble(splitz[1]);
                        
                        Parameters p = new Parameters(epoch, longitude, lattitude);
                        veh.add(p);
                    }
                    // Always close files.
                } catch (IOException ex) {
                                System.out.println("exception1 : "+ex);
                } 
            } catch (FileNotFoundException ex) {
                System.out.println("exception : "+ex);
            } finally {     
                try {
                    fileReader.close();
                } catch (IOException ex) {
                        System.out.println("exception : "+ex);
                }
            }
           
            return delete_duplicates(veh);               
        }
    }