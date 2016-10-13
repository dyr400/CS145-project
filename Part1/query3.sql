select count(*)
from (select ItemID from Category group by ItemID having count(distinct Categ) = 4);
