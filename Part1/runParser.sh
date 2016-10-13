rm *.dat

python my_parser.py /usr/class/cs145/project/ebay_data/items-*.json

sort item0.dat > item.dat
uniq -d item.dat
sort user0.dat > user.dat
uniq -d user.dat
sort bid0.dat > bid.dat
uniq -d bid.dat
sort category0.dat > category.dat
uniq -d category.dat
