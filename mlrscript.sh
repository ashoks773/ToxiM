sed 's/,/ /g' caco_test > caco_test1 # Input file contains mutiple variables
./transpose.awk caco_test1 > caco_test2
head -1 caco_test2 > header
tail -1 caco_test2 > tail1 
grep -w -f Top caco_test2 > caco_test3 # Provide list of important variables to make that file here the list of 30 imp is in Top_30 file
cat header caco_test3 tail1 > caco_test4
./transpose.awk caco_test4 > caco_test5
sed -i 's/ /,/g' caco_test5
rm caco_test1 caco_test2 header caco_test3 caco_test4 tail1
mv caco_test5 caco_test_top11
