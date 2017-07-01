
/*
 * Course       : Cooperative Communicative vehicles
 * Assignment   : Java Project 3
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
import java.text.SimpleDateFormat;
import java.util.Date;
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
        
    public List<Parameters> delete_duplicates(List<Parameters> list){
        Iterator<Parameters> iterator = list.iterator();
        Parameters param = null,preParam;
        preParam = iterator.next();
        while(iterator.hasNext()){
            param = iterator.next();
            // Using Haversine formula for caluculations
            if (param.getEpoch() - preParam.getEpoch() == 0) {
                list.remove(param);
            } 
        }
        return list;
    }
    
    public BufferedWriter copyFile(String source, String destination){
        
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
    
    
    public void process_icw(List<Parameters> veh) throws IOException{
        Iterator<Parameters> vi = veh.iterator();
        Parameters cVeh = null, pVeh1=null, pVeh2=null;
        VehiclePoly v1Poly = null, v2Poly = null;
        BufferedWriter writer = copyFile("prototype.kml", "output.kml");

        while(vi.hasNext()){
            
            cVeh= vi.next();
            Parameters pVeh = null;
            VehiclePoly vPoly = null;
            String style = null;
            
            if ("v1".equals(cVeh.getVehId())){
                if(pVeh1 == null){
                    pVeh1 = cVeh;
                    continue;
                }
                pVeh = pVeh1;
            }else if ("v2".equals(cVeh.getVehId())){
                if(pVeh2 == null){
                    pVeh2 = cVeh;
                    continue;
                }
                pVeh = pVeh2;
            }
            double distance = GpsReader.calculateDistance(pVeh.getLattitude(), cVeh.getLattitude(),
                                                            pVeh.getLongitude(), cVeh.getLongitude());
            double heading = GpsReader.caluculateHeading(pVeh.getLattitude(), cVeh.getLattitude(),
                                                           pVeh.getLongitude(), cVeh.getLongitude());
            double speed = distance/(cVeh.getEpoch() - pVeh.getEpoch());
            
            if ("v1".equals(cVeh.getVehId())){
                v1Poly = new VehiclePoly(speed, heading, cVeh.getLattitude(), cVeh.getLongitude());
                vPoly = v1Poly;
                if(v2Poly == null){
                    style = "msn_cabs1";
                }else if(v1Poly.checkIntersection(v2Poly)){
                    style = "msn_cabs3";
                }else{
                    style = "msn_cabs1";
                }
            }else if ("v2".equals(cVeh.getVehId())){
                v2Poly = new VehiclePoly(speed, heading, cVeh.getLattitude(), cVeh.getLongitude());
                vPoly = v2Poly;    
                style = "msn_cabs2";
            }else{
                continue;
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
            
            writer.append(   "   <Placemark>\n"
                                +"      <TimeSpan>\n"
                                +"          <begin>"+sdf.format(new Date((long) pVeh.getEpoch() * 1000))+"</begin>\n"
                                +"          <end>"+sdf.format(new Date((long) cVeh.getEpoch() * 1000))+"</end>\n"
                                +"      </TimeSpan>\n"
                                +"   <styleUrl>#"+ style +"</styleUrl>\n"
                                +"   <MultiGeometry>\n"
                                +"      <Point>\n"
                                +"          <coordinates>"+cVeh.getLongitude()+","+cVeh.getLattitude()+",0"+"</coordinates>\n"
                                +"      </Point>\n"
                                +"      <Polygon>\n"
                                +"          <altitudeMode>clampToGround</altitudeMode>\n"
                                +"          <outerBoundaryIs>\n"
                                +"              <LinearRing>\n"
                                +"                  <coordinates>"
                                +                       vPoly.getKmlPolyString(6)
                                +"                  </coordinates>\n"
                                +"              </LinearRing>\n"
                                +"          </outerBoundaryIs>\n"
                                +"      </Polygon>\n"
                                +"  </MultiGeometry>\n"
                                +"  </Placemark>\n");

            if ("v1".equals(cVeh.getVehId())){
                pVeh1 = cVeh;
            }else if ("v2".equals(cVeh.getVehId())){
                pVeh2 = cVeh;
            }        
        }
        writer.append("\t</Document>\n</kml>");
        writer.close();
    } 

    public static double caluculateHeading(double lat1 , double lat2,
                                           double long1, double long2){
        lat1=toRadians(lat1);
        lat2=toRadians(lat2);
        long1=toRadians(long1);
        long2=toRadians(long2);
        double y = Math.sin(long2-long1) * Math.cos(lat2);
        double x = Math.cos(lat1)*Math.sin(lat2) -
                Math.sin(lat1)*Math.cos(lat2)*Math.cos(long2-long1);
        return (toDegrees(Math.atan2(y, x)) + 360) %360;
    }

    public static double calculateDistance(double lat1 , double lat2,
                                            double long1, double long2){
        double phi1 = toRadians(lat1);
        double phi2 = toRadians(lat2);
        double dPhi = toRadians(lat2 - lat1);
        double dLambda = toRadians(long2 - long1);
        double a = Math.sin(dPhi/2) * Math.sin(dPhi/2) +
                   Math.cos(phi1) * Math.cos(phi2) *
                   Math.sin(dLambda/2) * Math.sin(dLambda/2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        return RADIUS * c;    
    }
    
}
