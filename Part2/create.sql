drop table if exists Item;
drop table if exists AuctionUser;
drop table if exists Bid;
drop table if exists Category;

create table Item (ItemID BIGINT PRIMARY KEY, UserID VARCHAR(30) references AuctionUser(UserID), Name VARCHAR(30), Currently FLOAT, Buy_Price FLOAT, First_Bid FLOAT, Number_of_Bids INT, Started SMALLDATETIME, Ends SMALLDATETIME CHECK(Ends > Started), Description TEXT);

create table AuctionUser (UserID VARCHAR(30) PRIMARY KEY, Rating INT, Location VARCHAR(30), Country VARCHAR(30));

create table Bid (ItemID BIGINT references Item(ItemID), UserID VARCHAR(30) references AuctionUser(UserID), Time SMALLDATETIME, Amount FLOAT, PRIMARY KEY (ItemID, UserID, Amount), UNIQUE(ItemID, Time), UNIQUE(ItemID, UserID, Amount));

create table Category (ItemID BIGINT references Item(ItemID), Categ VARCHAR(40), UNIQUE(ItemID, Categ));

drop table if exists CurrentTime;
create table CurrentTime (Time SMALLDATETIME);
insert into CurrentTime values ('2001-12-20 00:00:01');
select * from CurrentTime;
