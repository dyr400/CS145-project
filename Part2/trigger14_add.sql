--description: <Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.>

PRAGMA foreign_keys = ON;
drop trigger if exists enforce_bid_rule;

create trigger enforce_bid_rule
before insert on Bid
for each row
when exists (
	select *
	from Bid b
	where b.ItemID = new.ItemID and b.Amount >= new.Amount
)
begin
	select raise(rollback, 'Constraint #14: A user may only place higher bids.');
end;
