
/**
 *
 * @author Sunny
 */
public class CalcOffset {
    private double  lat,lon;
    public static final long R = 6371000;
    
    public CalcOffset(double lat1, double lon1, double d, double brng){
        double lat2 = Math.asin( Math.sin( lat1 ) * Math.cos( d / R ) + Math.cos( lat1 ) * Math.sin( d / R ) * Math.cos( brng ) );
        double lon2 = lon1 + Math.atan2( Math.sin( brng ) * Math.sin( d / R ) * Math.cos( lat1 ), Math.cos( d / R ) - Math.sin( lat1 ) * Math.sin( lat2 ) );
        this.lat = lat2;
        this.lon = lon2;        
    }

    public double getLat() {
        return lat;
    }
    public double getLatInDeg() {
        return lat * ( 180 / Math.PI);
    }

    public double getLon() {
        return lon;
    }       

    public double getLonInDeg() {
        return lon * ( 180 / Math.PI);
    }       
}
