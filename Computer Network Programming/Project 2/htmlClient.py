
##########################################################################################
# Course        : Computer Networks and Programming, Winter 2017
# project       : project 2
# author        : Sai Sundeep Innamuri - 004507888, Rajeev Bhupathiraju - 004570122
# file name     : htmlClient.py
# date Written  : Feb 25 2017
##########################################################################################

from HTMLParser import HTMLParser
from HTMLParser import HTMLParser as hp
import sys
import datetime
from socket import *
import shutil
import os
import platform
import time
HTTPGETRequestFormat = "GET {} HTTP/1.1\nHost: {}\n\n"
httpPort = 80
# serverSocket = socket(AF_INET, SOCK_STREAM)


# create a subclass and override the handler methods
class MyHTMLParser(HTMLParser):
    title = None
    images= list()
    next_tag_data_type = None

    def getAttrValue(self, attrs, key):
        for attr in attrs:
            if attr[0] == key: return  attr[1]

    def handle_starttag(self, tag, attrs):
        if tag == 'title': self.next_tag_data_type = 'title'
        elif tag == 'img':
            self.images.append(self.getAttrValue(attrs,"src"))
            # print HTMLParser.getpos(self)
            # print self.getAttrValue(attrs,"src")
    def handle_data(self, data):
        if self.next_tag_data_type == 'title' :
            self.title = data.replace(" ","_").replace("\n","")
        self.next_tag_data_type = None

def writeFile(path, file, body):
    if not os.path.exists(path):
        # print os.path.basename(path)
        os.mkdir(path)
    elif file.rfind("/") != -1:
        os.mkdir(path + "/" + file[:file.rfind("/")])

    htmlfile = open(path + '/' + file, "wb")
    htmlfile.write(body)
    htmlfile.close()


#function to seperate header and body from a html response
def getHeadersNBody(response):

    headers = response[: response.index("\r\n\r\n")]
    body = response[response.index("\r\n\r\n") + 4:]
    headers = headers.split("\r\n")
    headersDict = dict()
    headersDict["status"]=headers[0][9:12]
    headers = headers[1:]
    # print headers
    #making a dictonary object for headers
    for header in headers:
        try:
            sp = header.split(": ")
            headersDict[sp[0]] = sp[1]
        except Exception, e:
            # print "cannot parse header" + header
            None
    return headersDict, body


#function to send and receive HTTP request
def sendRecvHTTPReq(host, HTTPRequest):
    print HTTPRequest[:-4]
    serverSocket = socket(AF_INET, SOCK_STREAM)
    serverSocket.connect((host, httpPort))
    #sending the http request
    serverSocket.send(HTTPRequest)
    #receving the response
    response = serverSocket.recv(10000)
    headers, body = getHeadersNBody(response)
    print "status : " + headers["status"]

    # handling differt status codes
    if headers["status"] in ('302', '301', '307' ):
        protocal, host, request = extractDetailFromURL(headers["Location"])
        headers, body = sendRecvHTTPReq(host, HTTPGETRequestFormat.format(request, host))
        serverSocket.close()
        return headers, body
    elif headers["status"] != '200':
        # print response
        print "Some error in request. HTTP error code " + headers["status"]
        print "Exiting"
        serverSocket.close()
        sys.exit(2)

    #receving more messages if the entire conteent is not received in one request
    contentReceived = len(body)
    if "Content-Length" in headers.keys():
        print "content is chunked. downloading in Iterations"
        while (contentReceived < int(headers["Content-Length"])):
            body = body + serverSocket.recv(10000)
            contentReceived = len(body)
    elif "Transfer-Encoding" in headers.keys() and headers["Transfer-Encoding"] == "chunked":
        print "content is chunked. downloading in Iterations"
        while (1):
            newChunk = serverSocket.recv(10000)
            if newChunk == "": break
            body = body + newChunk
            time.sleep(1)

    print ""
    serverSocket.close()

    return headers,body


#function to download an array of bojects from src tag
def processReqArray(homepage, reqArray, host, folderToSave):

    for request in reqArray:
        try:
            if request[:4] == 'http':
                protocal, host, request = extractDetailFromURL(request)
                req = HTTPGETRequestFormat.format(request, host)
            elif request[0] != "/" : req = HTTPGETRequestFormat.format(homepage + request, host)
            else: req = HTTPGETRequestFormat.format(request, host)

            headers, body = sendRecvHTTPReq(host, req)
            writeFile(folderToSave, request, body)
        except:
            None
            #continue with the next request

#to extract details from URL
def extractDetailFromURL(htmlReq):
    protocal = htmlReq.split("://")
    host = protocal[1].split("/")[0]
    request = protocal[1][protocal[1].index('/'):]
    protocal = protocal[0]
    return protocal, host, request

def main():
    parser = MyHTMLParser()
    try:
        #storing the web site request in to a variable
        protocal, host, indexReq = extractDetailFromURL(sys.argv[1])
        # serverSocket.connect((host, httpPort))
        headers,body = sendRecvHTTPReq(host, HTTPGETRequestFormat.format(indexReq, host))
        websiteHome = indexReq[:indexReq[1:].index("/")+2]
        #to parse the HTML files
        parser.feed(body)

        if os.path.exists(parser.title):
            for root, dirs, files in os.walk(parser.title, topdown=False):
                for name in files:
                    os.remove(os.path.join(root, name))
                for name in dirs:
                    os.rmdir(os.path.join(root, name))
        else:  os.mkdir(parser.title)
        # htmlfile = open(parser.title + "/" + parser.title +".html" , "wb")

        writeFile(parser.title, parser.title +".html", body )

        #to download the images
        processReqArray(websiteHome, parser.images, host, parser.title)
        # serverSocket.close()
    except Exception,e :
        print str(e) + " ignored"
    finally:
        if os.path.exists(parser.title):
            print ""
            print "please check {} folder for downloaded html website".format(parser.title)

if __name__ == '__main__':
    main()

