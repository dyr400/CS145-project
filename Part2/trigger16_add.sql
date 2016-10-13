--description: <The current time of your AuctionBase system can only advance forward in time, not backward in time.>

PRAGMA foreign_keys = ON;
drop trigger if exists enforce_time_elapse;

create trigger enforce_time_elapse
before update on CurrentTime
for each row
when exists (
	select *
	from CurrentTime c
	where c.Time > new.Time
)
begin
	select raise(rollback, 'Constraint #16: The current time of system can only advance forward.');
end;
