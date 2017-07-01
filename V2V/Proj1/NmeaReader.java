/*
 * Course       : Cooperative Communicative vehicles
 * Assignment   : Java Project 1
 * Author       : Sundeep Innamuri - 004507888
 * File         : NmeaReader.java
 * Discription  : to read .nmea files
 * Written on   : 21 June 2016 
 */

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.text.ParseException;

public class NmeaReader extends GpsReader {

    NmeaReader(String filePath){
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
                outer:
                while ((line = bufferedReader.readLine()) != null) {
                    lineCount++;
                    line = line.trim();     
                    if("".equals(line)) continue;
                    String splitz[] = line.split(",");
                    if("$GPRMC".equals(splitz[0])){ //// remove in higher jdk
                        for(int i = 0; i <10; i++){
                            if(splitz[i].length() == 0 ) {                                        
                               continue outer;// remove in higher jdk
                            }
                        }      
                        SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyHHmmss.S");
                        Calendar calendar = GregorianCalendar.getInstance(); // creates a new calendar instance
                        try{
                            Date date = sdf.parse(splitz[9]+splitz[1]);
                            calendar.setTime(date);   // assigns calendar to given date
                        }catch (ParseException ex) {
                            System.out.println("line :" +lineCount +" Exception : "+ex);
                            System.out.println("This line will be ignored"); 
                            continue;
                        }
                        double epoch = calendar.getTimeInMillis() / 1000L;
                        double lattitude = Double.parseDouble(splitz[3])/100;
                        lattitude = (int)lattitude + (lattitude - (int)lattitude)*5/3;
                        if (splitz[4].charAt(0) == 'S') lattitude = -1 * lattitude;
                        double longitude = Double.parseDouble(splitz[5])/100;
                        longitude = (int)longitude + (longitude - (int)longitude)*5/3;
                        if (splitz[6].charAt(0) == 'W') longitude = -1 * longitude;
                        Parameters p = new Parameters(epoch, longitude, lattitude);
                        list.add(p);
                    }

                }
            } catch (IOException ex) {
                System.out.println("exception : "+ex);
                System.exit(3);
            }
        } catch (FileNotFoundException ex) {
            System.out.println("exception : "+ex);
            System.exit(3);
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
