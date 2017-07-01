/*
 * Course       : Cooperative Communicative vehicles
 * Assignment   : Java Project 1
 * Author       : Sundeep Innamuri - 004507888
 * File         : GpsReader.java
 * Discription  : to read gps data
 * Written on   : 21 June 2016 
 */

import static java.lang.Math.toDegrees;
import java.util.Iterator;
import java.util.List;
import static java.lang.Math.toRadians;
/**
 *
 * @author Sunny
 */
public abstract class GpsReader {
    String filePath;
    public static final long RADIUS = 6371000;
    double minSpeed = 0,maxSpeed =0,avgSpeed =0,avgHeading =0,minHeading =0,maxHeading =0,distance=0;
 
   GpsReader(String filePath){
        this.filePath =filePath;
    }
    public abstract List<Parameters> readFile();

    public void calculate_values(List<Parameters> list){
        if(list.isEmpty()){
            System.out.println("No Data in the file");
            return;
        }
        Iterator<Parameters> iterator = list.iterator();
        Parameters param = null,preParam;
        preParam = iterator.next();
        boolean isInit = false;
        double totalHeading = 0;
        int count =1 ;
        while(iterator.hasNext()){
            param = iterator.next();
            // Using Haversine formula for caluculations
            if (param.epoch - preParam.epoch == 0) {
                preParam = param;
                continue;
            } 
            double distance = GpsReader.calculateDistance(preParam.lattitude, param.lattitude,
                                                       preParam.longitude, param.longitude);
            double heading = GpsReader.caluculateHeading(preParam.lattitude, param.lattitude,
                                                         preParam.longitude, param.longitude);
            double speed = distance/(param.epoch - preParam.epoch);
            this.distance = this.distance + distance;
            
            totalHeading = totalHeading + heading;
            if(isInit){
                if (minSpeed > speed) minSpeed = speed;
                if (maxSpeed < speed) maxSpeed = speed;
                if (minHeading > heading) minHeading = heading;
                if (maxHeading < heading) maxHeading = heading;
            }else{
                minSpeed = speed;
                maxSpeed = speed;
                minHeading = heading;
                maxHeading = heading;
                isInit = true;
            }
            count ++;
            preParam = param;
        }
        Parameters first = list.get(0);
        this.avgSpeed = this.distance/(param.epoch - first.epoch);
        this.avgHeading = totalHeading / (count-1);
        System.out.println("Total time [sec]:"+(param.epoch - first.epoch));
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
    
    public void printValues(){
        System.out.printf("Minimum Speed [m/s]:%.2f\n",minSpeed);
        System.out.printf("Maximum Speed [m/s]:%.2f\n",maxSpeed);
        System.out.printf("Average Speed [m/s]:%.2f\n",avgSpeed);
        System.out.printf("Minimum Heading [degrees]:%.2f\n",minHeading);
        System.out.printf("Maximum Heading [degrees]:%.2f\n",maxHeading);
        System.out.printf("Average Heading [degrees]:%.2f\n",avgHeading);
        System.out.printf("Total Distance Traveled [m]:%.2f\n",distance);
    }
}
