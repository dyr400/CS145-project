--description: <In every auction, the Number_of_Bids attribute corresponds to the actual number of bids for that particular item.>

PRAGMA foreign_keys = ON;
drop trigger if exists enforce_number_of_bids;

create trigger enforce_number_of_bids
after insert on Bid
for each row
begin
	update Item set Number_of_Bids = Number_of_Bids + 1
	where ItemID = new.ItemID;
end;
