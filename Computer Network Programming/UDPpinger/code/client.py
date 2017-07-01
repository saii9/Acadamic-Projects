
import datetime
from socket import *

epoch = datetime.datetime.utcfromtimestamp(0)
#to find the time differnce in millis
def getEpoch(dt):
    return (dt - epoch).total_seconds() * 1000.0

# Create a UDP socket\
clientSocket = socket(AF_INET, SOCK_DGRAM)
clientSocket.settimeout(1)
host="192.168.0.19"
#host='localhost'
port=12000
# Assign IP address and port number to socket

pingId = 0
rrts = list()
min = None
max = None
sum = 0
while pingId < 12:
    pingId = pingId + 1
    #message for the ping
    start = datetime.datetime.now()
    message = 'ping '+ str(start) + " " + str(pingId)
    print "Sending Msg  : " + message

    try:
        #sending the message
        clientSocket.sendto(message,(gethostbyname(host),port))
        response, address = clientSocket.recvfrom(1024)
        #find the RRT
        print "Received Msg : " + response
        RRT = getEpoch(datetime.datetime.now()) - getEpoch(start)
        print "RRT : "+ str(RRT)
        rrts.append(RRT)
        sum = sum + RRT
        #ti fing the min and mx
        if RRT < min or min is None : min = RRT
        if RRT > max or max is None : max = RRT
    except timeout, st:
        #exception handler to catch the socket timeout
        print "Timed out"
        continue

print ""
#sorting the rrt to find the median
rrts.sort()
print rrts
print "No of success " +str(len(rrts))
median = None
if len(rrts) > 0:
    if len(rrts)%2 == 0:
        median = (rrts[len(rrts)/2] + rrts[len(rrts)/2 - 1])/2
    else :
        median = rrts[int(len(rrts)/2)]

print "the min    is " +str(min)
print "the max    is " +str(max)
print "the mean   is " +str(sum/ len(rrts))
print "the median is " +str(median)
