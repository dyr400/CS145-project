
"""
FILE: skeleton_parser.py
------------------
Author: Firas Abuzaid (fabuzaid@stanford.edu)
Author: Perth Charernwattanagul (puch@stanford.edu)
Modified: 04/21/2014

Skeleton parser for CS145 programming project 1. Has useful imports and
functions for parsing, including:

1) Directory handling -- the parser takes a list of eBay json files
and opens each file inside of a loop. You just need to fill in the rest.
2) Dollar value conversions -- the json files store dollar value amounts in
a string like $3,453.23 -- we provide a function to convert it to a string
like XXXXX.xx.
3) Date/time conversions -- the json files store dates/ times in the form
Mon-DD-YY HH:MM:SS -- we wrote a function (transformDttm) that converts to the
for YYYY-MM-DD HH:MM:SS, which will sort chronologically in SQL.

Your job is to implement the parseJson function, which is invoked on each file by
the main function. We create the initial Python dictionary object of items for
you; the rest is up to you!
Happy parsing!
"""

import sys
from json import loads
from re import sub

columnSeparator = "|"

# Dictionary of months used for date transformation
MONTHS = {'Jan':'01','Feb':'02','Mar':'03','Apr':'04','May':'05','Jun':'06',\
        'Jul':'07','Aug':'08','Sep':'09','Oct':'10','Nov':'11','Dec':'12'}

"""
Returns true if a file ends in .json
"""
def isJson(f):
    return len(f) > 5 and f[-5:] == '.json'

"""
Converts month to a number, e.g. 'Dec' to '12'
"""
def transformMonth(mon):
    if mon in MONTHS:
        return MONTHS[mon]
    else:
        return mon

"""
Transforms a timestamp from Mon-DD-YY HH:MM:SS to YYYY-MM-DD HH:MM:SS
"""
def transformDttm(dttm):
    dttm = dttm.strip().split(' ')
    dt = dttm[0].split('-')
    date = '20' + dt[2] + '-'
    date += transformMonth(dt[0]) + '-' + dt[1]
    return date + ' ' + dttm[1]

"""
Transform a dollar value amount from a string like $3,453.23 to XXXXX.xx
"""

def transformDollar(money):
    if money == None or len(money) == 0:
        return money
    return sub(r'[^\d.]', '', money)

"""
Parses a single json file. Currently, there's a loop that iterates over each
item in the data set. Your job is to extend this functionality to create all
of the necessary SQL tables for your database.
"""
def parseJson(json_file):
    #num = str(json_file[-7:-5])
    #if num[0] == '-': num = str(num[1])

    fileNames = ["item0.dat", "user0.dat", "bid0.dat", "category0.dat"]    
    out_item = open(fileNames[0], 'a')
    out_user = open(fileNames[1], 'a')
    out_bid = open(fileNames[2], 'a')
    out_category = open(fileNames[3], 'a')
    with open(json_file, 'r') as f:
        items = loads(f.read())['Items'] # creates a Python dictionary of Items for the supplied json file	
        for item in items:
            """
            TODO: traverse the items dictionary to extract information from the
            given `json_file' and generate the necessary .dat files to generate
            the SQL tables based on your relation design
            """
            ItemID = item["ItemID"]
            Name = '"' + str(item["Name"]).replace('"', '""') + '"'
            Category = item["Category"]
            Currently = transformDollar(str(item["Currently"]))
            if item.get("Buy_Price") != None:
                Buy_Price = transformDollar(str(item["Buy_Price"]))
            else: Buy_Price = "NULL"
            First_Bid = transformDollar(str(item["First_Bid"]))
            Number_of_Bids = item["Number_of_Bids"]
            Location = '"' + str(item["Location"]).replace('"', '""') + '"'
            Country = '"' + str(item["Country"]).replace('"', '""') + '"'
            Started = transformDttm(str(item["Started"]))
            Ends = transformDttm(str(item["Ends"]))
            if type(item["Bids"]) == list:
                Bids = item["Bids"]
            else: Bids = []
            UserID = '"' + str(item["Seller"]["UserID"]).replace('"', '""') + '"'
            Rating = item["Seller"]["Rating"]
            Description = '"' + str(item["Description"]).replace('"', '""') + '"'
            
            out_item.write(ItemID + "|"+ UserID + "|" + Name + "|" + Currently + "|" + Buy_Price + "|")
            out_item.write(First_Bid + "|" + Number_of_Bids + "|" + Started + "|" + Ends + "|" + Description + "\n")
            out_user.write(UserID + "|" + Rating + "|" + Location + "|" + Country + "\n")
            for eachCat in Category:
                out_category.write(ItemID + "|"  + '"' + str(eachCat) + '"' + "\n")
            
            if Bids == []: pass
            else:                
                #elements are dicts, keys are {Bid, Time, Amount}
                for elements in Bids:
                    Time = transformDttm(str(elements["Bid"]["Time"]))
                    Amount = transformDollar(str(elements["Bid"]["Amount"]))
                    BidderDict = elements["Bid"]["Bidder"]
                    BUserID = '"' + str(BidderDict["UserID"]).replace('"', '""') + '"'
                    BRating = BidderDict["Rating"]
                    if BidderDict.get("Location") != None:
                        BLocation = '"' + str(BidderDict["Location"]).replace('"', '""') + '"'
                    else: BLocation = "NULL"
                    if BidderDict.get("Country") != None:
                        BCountry = '"' + str(BidderDict["Country"]).replace('"', '""') + '"'
                    else: BCountry = "NULL"
                    out_bid.write(ItemID + "|" + BUserID + "|" + Time + "|" + Amount + "\n")
                    out_user.write(BUserID + "|" + BRating + "|")
                    out_user.write(BLocation + "|" + BCountry + "\n")
        out_item.close()
        out_user.close()
        out_bid.close()
        out_category.close()

"""
Loops through each json files provided on the command line and passes each file
to the parser
"""
def main(argv):
    if len(argv) < 2:
        print(sys.stderr, 'Usage: python skeleton_json_parser.py <path to json files>')
        sys.exit(1)
    # loops over all .json files in the argument
    for f in argv[1:]:
        if isJson(f):
            parseJson(f)
            print("Success parsing " + f)

if __name__ == '__main__':
    main(sys.argv)
