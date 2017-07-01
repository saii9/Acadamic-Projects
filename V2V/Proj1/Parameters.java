/*
 * Course       : Cooperative Communicative vehicles
 * Assignment   : Java Project 1
 * Author       : Sundeep Innamuri - 004507888
 * File         : Parameters.java
 * Discription  : Data Structure class to hold gps data
 * Written on   : 21 June 2016 
 */


public class Parameters {
    double epoch;
    double longitude;
    double lattitude;

    public Parameters(double epoch,double longitude,double lattitude) {
        this.epoch = epoch;
        this.longitude = longitude;
        this.lattitude = lattitude;
        //System.out.println("epoch "+epoch+" lattitude "+lattitude +" longitude "+longitude);
    }
    public void setParam(double epoch,double longitude,double lattitude) {
        this.epoch = epoch;
        this.longitude = longitude;
        this.lattitude = lattitude;
    }
}
