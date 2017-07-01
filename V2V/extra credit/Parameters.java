
/*
 * Course       : Cooperative Communicative vehicles
 * Assignment   : Java Project 1
 * Author       : Sundeep Innamuri - 004507888
 * File         : Parameters.java
 * Discription  : Data Structure class to hold gps data
 * Written on   : 21 June 2016 
 */


public class Parameters {
    private double epoch;
    private GeoPoint geoDot;
    
    public Parameters(double epoch,double longitude,double lattitude) {
        this.epoch = epoch;
        geoDot = new GeoPoint();
        this.geoDot.setLon(longitude);
        this.geoDot.setLat(lattitude);
        //System.out.println("epoch "+epoch+" lattitude "+lattitude +" longitude "+longitude);
    }
    
    public void setParam(String vehId, double epoch,double longitude,double lattitude) {
        this.epoch = epoch;
        this.geoDot.setLon(longitude);
        this.geoDot.setLat(lattitude);
    }

    public GeoPoint getGeoDot() {
        return geoDot;
    }

    public void setGeoDot(GeoPoint geoDot) {
        this.geoDot = geoDot;
    }
    
    public double getEpoch() {
        return epoch;
    }

    public double getLongitude() {
        return geoDot.getLon();
    }

    public double getLattitude() {
        return geoDot.getLat();
    }

}
