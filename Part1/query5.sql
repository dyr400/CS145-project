select count(distinct U.UserID)
from AuctionUser U, Item I
where U.UserID = I.UserID and U.Rating > 1000;
