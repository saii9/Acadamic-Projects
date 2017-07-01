
##########################################################################################
# Course        : Computer Networks and Programming, Winter 2017
# project       : project 3
# author        : Sai Sundeep Innamuri - 004507888, Rajeev Bhupathiraju - 004570122
# file name     : htmlClient.py
# date Written  : Feb 25 2017
##########################################################################################

from HTMLParser import HTMLParser
from socket import *
import sys
import os
import time
from datetime import datetime
from datetime import timedelta

HTTPGETRequestFormat = "GET {} HTTP/1.1\nHost: {}\n\n"
httpPort = 80
# serverSocket = socket(AF_INET, SOCK_STREAM)
domain_names = ('com','org','edu','in','uk')

# create a subclass and override the handler methods
class MyHTMLParser(HTMLParser):
    title = None
    srcs= list()
    next_tag_data_type = None

    def getAttrValue(self, attrs, key):
        for attr in attrs:
             if attr[0] == key: return  attr[1]
        return None

    def handle_starttag(self, tag, attrs):

        if tag == 'title': self.next_tag_data_type = 'title'
        elif tag == 'img':
            src = self.getAttrValue(attrs, "src")
            if src not in self.srcs:
                self.srcs.append(self.getAttrValue(attrs,"src"))
        else:
            src = self.getAttrValue(attrs,"src")
            href= self.getAttrValue(attrs,"href")
            attrval = None

            if src is not None: attrval = src
            if href is not None: attrval = href
            if attrval is None: return
            if attrval.find('http') != -1: return
            # print attrval
            self.srcs.append(attrval)


    def handle_data(self, data):
        if self.next_tag_data_type == 'title' :
            self.title = data.replace(" ","_").replace("\n","").replace(":", "_")
        self.next_tag_data_type = None

#To write a file downloaded
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
    # print HTTPRequest[:-2]
    serverSocket = socket(AF_INET, SOCK_STREAM)
    serverSocket.connect((host, httpPort))
    serverSocket.settimeout(1)
    #sending the http request
    serverSocket.send(HTTPRequest)
    #receving the response
    response = serverSocket.recv(10000)
    headers, body = getHeadersNBody(response)
    # print "status : " + headers["status"]

    # handling differt status codes
    if headers["status"] in ('302', '301', '307' ):
        # print "Encountered redirection. Not sipported!"
        serverSocket.close()
        raise Exception
        # protocal, host, request = extractDetailFromURL(headers["Location"])
        # serverSocket.close()
        # headers, body = sendRecvHTTPReq(host, HTTPGETRequestFormat.format(request, host))
        # return headers, body

    elif headers["status"] != '200':
        # print response
        # print "Some error in request. HTTP error code " + headers["status"]
        # print "Exiting"
        serverSocket.close()
        raise Exception
        # sys.exit(2)

    #receving more messages if the entire conteent is not received in one request
    contentReceived = len(body)
    if "Content-Length" in headers.keys():
        # print "content is chunked. downloading in Iterations, Content length in header keys"
        while (contentReceived < int(headers["Content-Length"])):
            body = body + serverSocket.recv(10000)
            contentReceived = len(body)
    elif "Transfer-Encoding" in headers.keys() and headers["Transfer-Encoding"] == "chunked":
        # print "content is chunked. downloading in Iterations. no content length"
        while (1):
            newChunk = serverSocket.recv(10000)
            if newChunk == "": break
            body = body + newChunk
            time.sleep(1)

    serverSocket.close()
    return headers,body

def checkForDomainInString(request):
    for domain in domain_names:
        if domain_names.find('.'+domain) != -1 : return domain
        else: continue
    return None


#function to download an array of bojects from src tag
def processReqArray(homepage, reqArray, host, folderToSave):
    # print reqArray
    numObjects = 0
    srcs_to_replace = dict()

    for initreq in reqArray:
        try:
            request = initreq
            request = request.replace(" ", "%20")

            if request[0] != "/" :
                req = HTTPGETRequestFormat.format(homepage + request, host)
            elif request.find("//") != -1:
                nprotocal, nhost, nrequest = extractDetailFromURL(request)
                req = HTTPGETRequestFormat.format(nrequest, nhost)
            else:
                req = HTTPGETRequestFormat.format(request, host)

            headers, body = sendRecvHTTPReq(host, req)
            if initreq[-1] == "/": initreq = initreq[:-1]
            if initreq.rfind("/") != -1:
                savefile = initreq.replace("/", "_")
                # print "Save file "+ savefile
                if initreq not in srcs_to_replace.keys(): srcs_to_replace[initreq] = savefile
                writeFile(folderToSave, savefile, body)
            else: writeFile(folderToSave, initreq, body)
            numObjects = numObjects + 1
            sys.stdout.write("\rDownloading Object: %d name : %s" %(numObjects, request))
            sys.stdout.flush()
        except:
            numObjects = numObjects + 1
            sys.stdout.write("\rDownloading Object: %d name : %s" %(numObjects, request))
            sys.stdout.flush()
            # print "Exception, Proceeding wtith next"
    print ""
    return numObjects, srcs_to_replace


#to extract details from URL
def extractDetailFromURL(htmlReq):
    protocal = htmlReq.split("//")
    host = protocal[1].split("/")[0]
    request = protocal[1][protocal[1].index('/'):]
    protocal = protocal[0]
    return protocal, host, request


def main():
    print "downloading site with out Multi threading:" + sys.argv[1]
    parser = MyHTMLParser()
    try:
        start_time = datetime.now()
        print "start_time : " + str(start_time)
        #storing the web site request in to a variable
        protocal, host, indexReq = extractDetailFromURL(sys.argv[1])
        headers,body = sendRecvHTTPReq(host, HTTPGETRequestFormat.format(indexReq, host))
        websiteHome = indexReq if indexReq == "/" else indexReq[:indexReq[1:].index("/")+2]
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

        #to download the images
        num_objects, srcs_to_replace = processReqArray(websiteHome, parser.srcs, host, parser.title)

        end_time = datetime.now()
        print "end_time : " + str(end_time)

        for k,v in srcs_to_replace.items():
            # print "replacing keyy " +k+ " with "+v
            body = body.replace(k, v)
        # print "writing file : " + parser.title +".html"
        writeFile(parser.title, parser.title +".html", body )
        print "totaltime : "+ str(timedelta.total_seconds(end_time - start_time))
    except Exception,e :
        None
        print str(e) + " ignored"
    finally:
        None
        if os.path.exists(parser.title):
            print ""
            print "please check {} folder for downloaded html website".format(parser.title)

if __name__ == '__main__':
    main()