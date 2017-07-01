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
    private double longitude;
    private double lattitude;
    private String vehId;
    
    public Parameters(String vehId, double epoch,double longitude,double lattitude) {
        this.vehId = vehId;
        this.epoch = epoch;
        this.longitude = longitude;
        this.lattitude = lattitude;
        //System.out.println("epoch "+epoch+" lattitude "+lattitude +" longitude "+longitude);
    }
    
    public void setParam(String vehId, double epoch,double longitude,double lattitude) {
        this.epoch = epoch;
        this.longitude = longitude;
        this.lattitude = lattitude;
        this.vehId = vehId;
    }

    public String getVehId() {
        return vehId;
    }

    public void setVehId(String vehId) {
        this.vehId = vehId;
    }
    
    public double getEpoch() {
        return epoch;
    }

    public double getLongitude() {
        return longitude;
    }

    public double getLattitude() {
        return lattitude;
    }

}
