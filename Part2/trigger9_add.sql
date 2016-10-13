--description: <A user may not bid on an item he or she is also selling.>

PRAGMA foreign_keys = ON;
drop trigger if exists enforce_bid_on_self;

create trigger enforce_bid_on_self
before insert on Bid
for each row
when exists (
	select *
	from Item i
	where i.ItemID = new.ItemID and i.UserID = new.UserID
)
begin
	select raise(rollback, 'Constraint #9: A user may not bid on his/her own item.');
end;
