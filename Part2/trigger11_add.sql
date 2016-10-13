--description: <No auction may have a bid before its start time or after its end time.>

PRAGMA foreign_keys = ON;
drop trigger if exists enforce_bid_window;

create trigger enforce_bid_window
before insert on Bid
for each row
when exists (
	select *
	from Item i
	where i.ItemID = new.ItemID and (i.Started > new.Time or i.Ends < new.Time)
)
begin
	select raise(rollback, 'Constraint #11: A user may only bid in bid window.');
end;
