drop table if exists Item;
drop table if exists AuctionUser;
drop table if exists Bid;
drop table if exists Category;

create table Item (ItemID BIGINT, UserID VARCHAR(30), Name VARCHAR(30), Currently FLOAT, Buy_Price FLOAT, First_Bid FLOAT, Number_of_Bids INT, Started VARCHAR(30), Ends VARCHAR(30), Description TEXT, PRIMARY KEY (ItemID));
create table AuctionUser (UserID VARCHAR(30), ItemID BIGINT, Rating INT, Location VARCHAR(30), Country VARCHAR(30));
create table Bid (ItemID BIGINT, UserID VARCHAR(30), Time VARCHAR(30), Amount FLOAT, PRIMARY KEY (ItemID, UserID, Amount));
create table Category (ItemID BIGINT, Categ VARCHAR(40));
