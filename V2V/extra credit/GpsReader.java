/*
 * Course       : Cooperative Communicative vehicles
 * Assignment   : Java Project 1
 * Author       : Sundeep Innamuri - 004507888
 * File         : GpsReader.java
 * Discription  : to read gps data
 * Written on   : 21 June 2016 
 */

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import static java.lang.Math.toDegrees;
import java.util.Iterator;
import java.util.List;
import static java.lang.Math.toRadians;
import java.util.ArrayList;
/**
 *
 * @author Sunny
 */
public abstract class GpsReader {
    String filePath;
    public static final long RADIUS = 6371000;
  
   GpsReader(String filePath){
        this.filePath =filePath;
    }
    public abstract List<Parameters> readFile();
        
    public ArrayList<Parameters> delete_duplicates(List<Parameters> list){
        Iterator<Parameters> iterator = list.iterator();
        ArrayList<Parameters>  ret = new ArrayList<Parameters>();
        Parameters param = null,preParam;
        preParam = iterator.next();
        int count = 0;
        ret.add(count++ , preParam);
        
        while(iterator.hasNext()){
            param = iterator.next();
            // Using Haversine formula for caluculations
            if (param.getEpoch() - preParam.getEpoch() == 0) {
                preParam = param;
                continue;
            } 
            ret.add(count++ , param);
        }
        return ret;
    }
    
    public static BufferedWriter copyFile(String source, String destination){
        
        BufferedReader reader = null;
        BufferedWriter writer = null;
            try {
                    String sCurrentLine;
                    reader = new BufferedReader(new FileReader(source));
                    writer = new BufferedWriter(new FileWriter(destination));
                    while ((sCurrentLine = reader.readLine()) != null) {
                            writer.append(sCurrentLine+'\n');
                    }
            } catch (IOException e) {
                    e.printStackTrace();
            } finally {
                try {
                    if (reader != null)reader.close();
                   // if (writer != null)writer.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
            return writer;
    }
    
    
    public static double caluculateHeading(GeoPoint dot1 , GeoPoint dot2){
        double lat1=toRadians(dot1.getLat());
        double lat2=toRadians(dot2.getLat());
        double long1=toRadians(dot1.getLon());
        double long2=toRadians(dot2.getLon());
        double y = Math.sin(long2-long1) * Math.cos(lat2);
        double x = Math.cos(lat1)*Math.sin(lat2) -
                Math.sin(lat1)*Math.cos(lat2)*Math.cos(long2-long1);
        return (toDegrees(Math.atan2(y, x)) + 360) %360;
    }

    public static double calculateDistance(GeoPoint dot1 , GeoPoint dot2){
        double phi1 = toRadians(dot1.getLat());
        double phi2 = toRadians(dot2.getLat());
        double dPhi = toRadians(dot2.getLat() - dot1.getLat());
        double dLambda = toRadians(dot2.getLon() - dot1.getLon());
        double a = Math.sin(dPhi/2) * Math.sin(dPhi/2) +
                   Math.cos(phi1) * Math.cos(phi2) *
                   Math.sin(dLambda/2) * Math.sin(dLambda/2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        return RADIUS * c;    
    }
 }
