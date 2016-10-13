--description: <All new bids must be placed at the time which matches the current time of your AuctionBase system.>

PRAGMA foreign_keys = ON;
drop trigger if exists enforce_time;

create trigger enforce_time
before insert on Bid
for each row
when exists (
	select *
	from CurrentTime c
	where c.Time <> new.Time
)
begin
	select raise(rollback, 'Constraint #15: A user must bid at current time.');
end;
