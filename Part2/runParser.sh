rm *.dat

python my_parser.py /usr/class/cs145/project/ebay_data/items-*.json

sort item0.dat > items.dat
uniq items.dat > item.dat
sort user0.dat > users.dat
uniq users.dat > user.dat
sort bid0.dat > bids.dat
uniq bids.dat > bid.dat
sort category0.dat > categories.dat
uniq categories.dat > category.dat

rm item0.dat
rm items.dat
rm user0.dat
rm users.dat
rm bid0.dat
rm bids.dat
rm category0.dat
rm categories.dat
