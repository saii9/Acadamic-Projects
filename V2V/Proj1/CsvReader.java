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
        public List<Parameters> readFile(){
            FileReader fileReader = null;
            List<Parameters> list = new ArrayList<Parameters>();
            try {
                fileReader = new FileReader(filePath);
                try {
                    BufferedReader bufferedReader = new BufferedReader(fileReader);
                    String line;
                    int lineCount = 0;
                    while ((line = bufferedReader.readLine()) != null) {
                        lineCount++;
                        String splitz[] = line.split(",");
                        String dateTime = splitz[0];                    
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
                        Calendar calendar = GregorianCalendar.getInstance(); // creates a new calendar instance
                        try{
                            Date date = sdf.parse(dateTime);
                            calendar.setTime(date);   // assigns calendar to given date
                        }catch (ParseException ex) {
                            System.out.println("line :" +lineCount +" Exception : "+ex);
                            System.out.println("This line will be ignored"); 
                            continue;
                        }
                        double epoch = calendar.getTimeInMillis() / 1000L;
                        double longitude = Double.parseDouble(splitz[1]);
                        double lattitude = Double.parseDouble(splitz[2]);
                        Parameters p = new Parameters(epoch, longitude, lattitude);
                        list.add(p);
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
                    return list;                
        }
    }