sed 's/,/ /g' Training_top0.5per > Training_top0.5per1 # Input file contains mutiple variables
./transpose.awk Training_top0.5per1 > Training_top0.5per2
head -1 Training_top0.5per2 > header
tail -1 Training_top0.5per2 > tail 
grep -w -f Top_30 Training_top0.5per2 > Training_top0.5per3 # Provide list of important variables to make that file here the list of 30 imp is in Top_30 file
cat header Training_top0.5per3 tail > Training_top0.5per4
./transpose.awk Training_top0.5per4 > Training_top0.5per5
sed -i 's/ /,/g' Training_top0.5per5
rm Training_top0.5per1 Training_top0.5per2 header tail Training_top0.5per3 Training_top0.5per4
