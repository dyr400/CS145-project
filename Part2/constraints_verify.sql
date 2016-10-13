/* SELECT statement verifying RI constraint #2 */
select i.UserID
from Item i
where not exists (select * from AuctionUser u1 where u1.UserID = i.UserID)
union
select b.UserID
from Bid b
where not exists (select * from AuctionUser u2 where u2.UserID = b.UserID);

/* SELECT statement verifying RI constraint #4 */
select *
from Bid b
where not exists (select * from Item i where i.ItemID = b.ItemID);

/* SELECT statement verifying RI constraint #5 */
select *
from Category c
where not exists (select * from Item i where i.ItemID = c.ItemID);
