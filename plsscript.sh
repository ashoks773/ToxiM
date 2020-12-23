sed 's/,/ /g' caco_train > caco_train1 # Input file contains mutiple variables
./transpose.awk caco_train1 > caco_train2
head -1 caco_train2 > header
tail -1 caco_train2 > tail1 
grep -w -f Top caco_train2 > caco_train3 # Provide list of important variables to make that file here the list of 30 imp is in Top_30 file
cat header caco_train3 tail1  > caco_train4
./transpose.awk caco_train4 > caco_train5
sed -i 's/ /,/g' caco_train5
rm caco_train1 caco_train2 header caco_train3 caco_train4 tail1
mv caco_train5 caco_train_desc_top11
