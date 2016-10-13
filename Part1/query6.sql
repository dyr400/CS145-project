select count(*)
from (
	select distinct U.UserID
	from AuctionUser U, Item I
	where U.UserID = I.UserID
	intersect
	select distinct U.UserID
	from AuctionUser U, Bid B
	where U.UserID = B.UserID
);
