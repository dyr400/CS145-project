select ItemID
from Item
where Currently = (select max(I.Currently) from Item I);
