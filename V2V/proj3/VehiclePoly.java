
import java.awt.geom.Line2D;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Sunny
 */
public class VehiclePoly {
    private GeoPoint nr, fr, nl, fl; 
    public static final long RADIUS = 6371000;
    public static final int TTL = 8;
    public static final int HLW = 2; // half lane width
  
    public VehiclePoly(double speed, double heading, double lat, double lon){
        this.createPoly(speed, heading, lat, lon);
    }
    
    public void createPoly(double s, double h, double lat, double lon) {

         CalcOffset co = null;//CalcOffset(double lat1, double lon1, double d, double brng){
         //near right
         co = new CalcOffset(Math.toRadians(lat), Math.toRadians(lon), HLW, Math.toRadians((h + 90)%360));
        nr = new GeoPoint();
        this.nr.setLat(co.getLatInDeg());
        this.nr.setLon(co.getLonInDeg());
        
            //near left
        co = new CalcOffset(Math.toRadians(lat), Math.toRadians(lon), HLW, Math.toRadians((((h - 90) + 360)%360)));
        nl = new GeoPoint();
        this.nl.setLat(co.getLatInDeg());
        this.nl.setLon(co.getLonInDeg());
        
        co = new CalcOffset(Math.toRadians(lat), Math.toRadians(lon), TTL * s, Math.toRadians(h));
        double latF = co.getLatInDeg();
        double lonF = co.getLonInDeg();

        //far right
        co = new CalcOffset(Math.toRadians(latF), Math.toRadians(lonF), HLW, Math.toRadians((h + 90)%360));
        fr = new GeoPoint();
        this.fr.setLat(co.getLatInDeg());
        this.fr.setLon(co.getLonInDeg());
        
        //far left
        co = new CalcOffset(Math.toRadians(latF), Math.toRadians(lonF), HLW, Math.toRadians((((h - 90) + 360)%360)));
        fl = new GeoPoint();
        this.fl.setLat(co.getLatInDeg());
        this.fl.setLon(co.getLonInDeg());
    }
    
    public String getKmlPolyString(int numTab){ 
        String tab = "";
        for(int i=0; i<numTab; i++) tab = tab + '\t'; 
        return  '\n'+tab+String.valueOf(this.nr.getLon()) + ',' +String.valueOf(this.nr.getLat())
               +'\n'+tab+String.valueOf(this.nl.getLon()) + ',' +String.valueOf(this.nl.getLat())
               +'\n'+tab+String.valueOf(this.fl.getLon()) + ',' +String.valueOf(this.fl.getLat())
               +'\n'+tab+String.valueOf(this.fr.getLon()) + ',' +String.valueOf(this.fr.getLat())
                +'\n';
    }
    
    public ArrayList<GeoPoint> getGeoPointList(){
        ArrayList<GeoPoint> list = new ArrayList<GeoPoint>();
        list.add(0,nr);
        list.add(1,nl);
        list.add(2,fl);
        list.add(3,fr);        
        return list;
    }
    public boolean checkIntersection(VehiclePoly vPoly){

        ArrayList<GeoPoint> l1 = this.getGeoPointList();
        ArrayList<GeoPoint> l2 = vPoly.getGeoPointList();
        
        for(int i=0; i<=4; i++){
            Line2D line1 = new Line2D.Double(l1.get(i%4).getLon(), l1.get(i%4).getLat(), 
                                             l1.get((i+1)%4).getLon(), l1.get((i+1)%4).getLat());
        
            for(int j=0; j<=4; j++){
                Line2D line2 = new Line2D.Double(l2.get(j%4).getLon(), l2.get(j%4).getLat(), 
                                                 l2.get((j+1)%4).getLon(), l2.get((j+1)%4).getLat());
                if(line2.intersectsLine(line1)){
                    return true;
                }
            }
        }
        return false;
    }

}
