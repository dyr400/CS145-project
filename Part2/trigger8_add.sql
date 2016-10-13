--description: <The Current_Price of an item must always match the Amount of the most recent bid for that item.>

PRAGMA foreign_keys = ON;
drop trigger if exists enforce_price_match;

create trigger enforce_price_match
after insert on Bid
for each row
begin
	update Item set Currently = new.Amount
	where ItemID = new.ItemID;
end;
