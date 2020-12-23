# Preparation FP file
sed 's/,/\t/g' desc_train_top100 > desc_train_top1001
cut -f1 desc_train_top1001 > molid_desc1
#sed 's/,/\n/g' molid_desc1 > molid_desc11
sed '/Name/d' molid_desc1 > molid_desc11
sort molid_desc11 > molid_desc
head -1 TrainingFP_top10per > header_FP2
sed '1d' TrainingFP_top10per > TrainingFp_no_header
grep -w -f molid_desc TrainingFP_top10per > commonFP1
sort commonFP1 > commonFP2
sed 's/,/ /g' commonFP2 > commonFP3
./transpose.awk  commonFP3 > commonFP4
sed '$d' commonFP4 > commonFP5
./transpose.awk commonFP5 > commonFP6
sed 's/ /,/g' commonFP6 > commonFP_no_fac

# Preparation Desc
head -1 desc_train_top100 > header_desc2
sed '1d' desc_train_top100 > desc_train_no_header
sort desc_train_no_header > desc_train1
sed 's/,/ /g' desc_train1 > desc_train2
./transpose.awk desc_train2 > desc_train3
sed '1d' desc_train3 > desc_train4
./transpose.awk desc_train4 > desc_train5
sed 's/ /,/g' desc_train5 > desc_train_no_molid

paste commonFP_no_fac desc_train_no_molid > hybrid2
sed 's/\t/,/g' hybrid2 > hybrid1

# Header
sed 's/,/\n/g' header_FP2 > header_FP11
sed '/Factor/d' header_FP11 > header_FP1
./transpose.awk header_FP1 > header_FP12
sed 's/ /,/g' header_FP12 > header_FP

sed 's/,/\n/g' header_desc2 > header_desc21
sed '/Name/d' header_desc21 > header_desc22
./transpose.awk header_desc22 > header_desc23
sed 's/ /,/g' header_desc23 > header_desc

paste header_FP header_desc > header1
sed 's/\t/,/g' header1 > header
cat header hybrid1 > hybrid_train

rm header header1 header_desc header_desc22  header_desc21 header_FP header_FP1  header_FP11  hybrid1 hybrid2 desc_train_no_molid desc_train5 desc_train4 desc_train3  desc_train2 desc_train1 desc_train_no_header commonFP_no_fac commonFP6 commonFP5 commonFP4 commonFP3 commonFP2 commonFP1 TrainingFp_no_header header_FP2 header_desc2  molid_desc molid_desc11 molid_desc1 header_desc23 header_FP12 desc_train_top1001

