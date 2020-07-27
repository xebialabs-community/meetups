#
# Copyright 2020 XEBIALABS
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
import sys
import random
import json
import org.slf4j.Logger as Logger
import org.slf4j.LoggerFactory as LoggerFactory
from xlrelease.HttpRequest import HttpRequest

class Client(object):
    def __init__(self):
        self.logger = LoggerFactory.getLogger("meetup.Client")
        self.logger.error("meetup.Client Created ==================")
        return

    @staticmethod
    def get_client():
        return Client()

    def testServer(self, variables):
        httpConnection = variables['params']
        httpRequest = HttpRequest(httpConnection)
        response = httpRequest.get("/")
        self.logger.error("Response Status = %s" % response.getStatus())
        if response.getStatus() == 200:
            return
        sys.exit(-1)


    def meetup_randomnumbergenerator(self, variables):
        self.minVal = int(variables['minValue'])
        self.maxVal = int(variables['maxValue'])
        self.logger.error("Min Value = %s" % self.minVal)
        self.logger.error("Max Value = %s" % self.maxVal)
        self.ranVal = random.randint( self.minVal, self.maxVal )
        self.logger.error("Random Number = %s" % self.ranVal)
        return {"output" : str(self.ranVal)}

    def meetup_getpostcomments(self, variables):
        httpConnection = variables['server']
        httpRequest = HttpRequest(httpConnection, variables['username'], variables['password'])
        url = "/comments?postId=%s" % variables['postId']
        self.logger.error("Get Post Comments %s" % (url))
        response = httpRequest.get(url, contentType='application/json')
        jsonData = response.getResponse()
        data = json.loads( jsonData )
        listData = []
        for recordData in data:
            self.logger.error( recordData['body'] )
            listData.append( recordData['body'] )
        returnData = {"responseJson": jsonData, "comments": listData }
        return returnData
