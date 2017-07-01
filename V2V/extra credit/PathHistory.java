/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.BufferedWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;


/**
 *
 * @author Sunny
 */
public class PathHistory {

    public static final float K_PHDISTANCE_M                 = 300;          //(meters)
    public static final float K_PHDATAPOINTSSAMPLETIME_S     = 100;          //(ms)
    public static final float K_PHALLOWABLEERROR_M           = 1;            //(meters)
    public static final float K_PHSMALLDELTAPHI_R            = (float) 0.02; //(radians)
    public static final float K_PH_RADIUSWEIGHTONE           = (float) 0.5;  //(unitless)
    public static final float K_PH_RADIUSWEIGHTTWO           = (float) 0.5;  //(unitless)
    public static final float K_PH_CHORDLENGTHTHRESHOLD      = 310;          //(meters)
    public static final float K_PH_MAXESTIMATEDRADIUS        = 0x7FFFFF;     //(meters)    

    public void process_chpr(ArrayList<Parameters> veh) throws IOException {

        try { 
            BufferedWriter writer = GpsReader.copyFile("prototype.kml", "output.kml");
            ArrayList<Parameters>  PH_ConciseDataBuffer = new ArrayList<Parameters>();
            int elementPos = 0;
            double totalDist = 0;
            double incrementDist = 0;
            Parameters pStart = null, pPrev, pNext;
            double PH_ActualChordLength, PH_ActualError, dTheta, PH_EstimatedR, d;
            boolean doStart = true;
            for(int i = 0 ; i < veh.size(); i++){
                //System.out.println("----------- step 1 -----------------");
                if (i < 3) {
                    PH_ConciseDataBuffer.add(veh.get(i));
                    elementPos++;
                    writeKml(PH_ConciseDataBuffer, writer);
                    continue;
                }
                if(doStart)pStart = veh.get(i-2);
                pPrev = veh.get(i-1);
                pNext = veh.get(i);
                
                //System.out.println("----------- step 2 -----------------");
                PH_ActualChordLength = GpsReader.calculateDistance(pStart.getGeoDot(), pNext.getGeoDot());
                
                if(PH_ActualChordLength > K_PH_CHORDLENGTHTHRESHOLD){
                    PH_ActualError = K_PHALLOWABLEERROR_M + 1;
                    
                    //System.out.println("----------- step 7 -----------------");
                    if(PH_ActualError > K_PHALLOWABLEERROR_M){
                        PH_ConciseDataBuffer.add(pPrev);
                        elementPos++;
                        refineBuffer(PH_ConciseDataBuffer, writer); //step nine
                        doStart  = true;
                        writeKml(pPrev, pNext, PH_ConciseDataBuffer, writer);
                        continue;
                    }
                    
                    //System.out.println("----------- step 8 -----------------");
                    if(PH_ActualError < K_PHALLOWABLEERROR_M){
                        doStart  = false;
                        writeKml(pPrev, pNext, PH_ConciseDataBuffer, writer);
                        continue;
                    }
                    
                   // System.out.println("----------- step 9 -----------------");
                    refineBuffer(PH_ConciseDataBuffer, writer);
                    doStart  = true;
                    writeKml(pPrev, pNext, PH_ConciseDataBuffer, writer);
                    continue;
                }
                
                //System.out.println("----------- step 3 -----------------");
                dTheta = Math.abs(Math.toRadians(GpsReader.caluculateHeading(pStart.getGeoDot(), pPrev.getGeoDot())
                        - GpsReader.caluculateHeading(pPrev.getGeoDot(), pNext.getGeoDot())));
                //System.out.println("dtheta ---- "+(dTheta < K_PHSMALLDELTAPHI_R?0:1));
                //System.out.println("----------- step 4 -----------------");
                if(dTheta < K_PHSMALLDELTAPHI_R){
                    PH_ActualError=0;
                    PH_EstimatedR=K_PH_MAXESTIMATEDRADIUS;
                    //    Go to Step Eight,;
                    
                    //System.out.println("----------- step 8 -----------------");
                    if(PH_ActualError < K_PHALLOWABLEERROR_M){
                        doStart  = false;
                        writeKml(pPrev, pNext, PH_ConciseDataBuffer, writer);
                        continue;
                    }
                    
                    //System.out.println("----------- step 9 -----------------");
                    refineBuffer(PH_ConciseDataBuffer, writer);
                    doStart  = true;
                    writeKml(pPrev, pNext, PH_ConciseDataBuffer, writer);
                    continue;
                    
                }else{
                    PH_EstimatedR = PH_ActualChordLength/(2*Math.sin(dTheta/2));
                    //Otherwise Continue.
                }
                
                //System.out.println("----------- step 5 -----------------");
                d = PH_EstimatedR*Math.cos(dTheta/2);
                
                //System.out.println("----------- step 6 -----------------");
                PH_ActualError = PH_EstimatedR - d;
                
               // System.out.println("----------- step 7 -----------------");
                if(PH_ActualError > K_PHALLOWABLEERROR_M){
                    PH_ConciseDataBuffer.add(pPrev);
                    elementPos++;
                    refineBuffer(PH_ConciseDataBuffer, writer); //step nine
                    doStart  = true;
                    writeKml(pPrev, pNext, PH_ConciseDataBuffer, writer);
                    continue;
                }

                //System.out.println("----------- step 8 -----------------");
                if(PH_ActualError < K_PHALLOWABLEERROR_M){
                    doStart  = false;
                    writeKml(pPrev, pNext, PH_ConciseDataBuffer, writer);
                    continue;
                }
                
                //System.out.println("----------- step 9 -----------------");
                refineBuffer(PH_ConciseDataBuffer, writer);
                doStart  = true;
                writeKml(pPrev, pNext, PH_ConciseDataBuffer, writer);
            }
            
            writer.append("\t</Document>\n</kml>");
            writer.close();
        }catch(Exception e){
            System.out.println(e);
        }
    }
    
    public static String placeMarkKml(double startTime, double endTime, String style, Parameters p){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    
        return   "   <Placemark>\n"
                +"      <TimeSpan>\n"
                +"          <begin>"+sdf.format(new Date((long) (1469361600 + startTime) * 1000))+"</begin>\n"
                +"          <end>"+sdf.format(new Date((long) (1469361600 + endTime) * 1000))+"</end>\n"
                +"      </TimeSpan>\n"
                +"   <styleUrl>#"+style+"</styleUrl>\n"
                +"      <Point>\n"
                +"          <coordinates>"+p.getLongitude()+","+p.getLattitude()+",0"+"</coordinates>\n"
                +"      </Point>\n"
                +"  </Placemark>\n";
    }
    
    public void writeKml(ArrayList<Parameters> buffer, BufferedWriter writer) throws IOException{
        int count = 0;
        String style;
        for(Parameters p:buffer){
            if (count == buffer.size() - 1) style = "msn_cabs1"; 
            else  style = "msn_cabs2";
            writer.append(PathHistory.placeMarkKml(buffer.get(0).getEpoch(),buffer.get(buffer.size() - 1).getEpoch(), style, p));
            count ++;
        }
    }
    public void writeKml(Parameters pPrev, Parameters pNext, ArrayList<Parameters> buffer, BufferedWriter writer) throws IOException{
    
            double endTime = pNext.getEpoch();
            double startTime = pPrev.getEpoch();
            writer.append(PathHistory.placeMarkKml(startTime, endTime, "msn_cabs1", pNext));
            int count = 0;
            //System.out.println("Distance --" +GpsReader.calculateDistance(buffer.get(buffer.size() - 1).getGeoDot(), buffer.get(0).getGeoDot()));
            for(Parameters p:buffer){
                //System.out.println((++count)+"-----"+p.getEpoch()+"-----"+p.getLattitude()+"-----"+p.getLongitude());
                writer.append(PathHistory.placeMarkKml(startTime, endTime, "msn_cabs2", p));
        }
    }
    public void refineBuffer(ArrayList<Parameters> buffer, BufferedWriter writer) throws IOException{
        double totalDistance = 0;
        for(int i=buffer.size() - 1; i > 0; i--){
            totalDistance = totalDistance + GpsReader.calculateDistance(buffer.get(i).getGeoDot(), buffer.get(i-1).getGeoDot());
            if(totalDistance > K_PHDISTANCE_M){
                buffer.subList(0, i).clear();
                break;
            }
        }
        
    }
}
