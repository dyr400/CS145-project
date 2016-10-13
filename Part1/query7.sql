select count(distinct C.Categ)
from Category C
where exists  (select * from Bid B where C.ItemID = B.ItemID and B.Amount > 100);
