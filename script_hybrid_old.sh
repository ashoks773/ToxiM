#http://ccm.net/faq/1451-delete-lines-from-a-file-using-sed
# file1 preparation

sed 's/,/ /g' TrainingFP_top10per > TrainingFP_top10per1
./transpose.awk TrainingFP_top10per1 > TrainingFP_top10per2
head -1 TrainingFP_top10per2 > mol_id1
sed 's/ /\n/g' mol_id1 > mol_id2
sed '/Name/d' mol_id2 > mol_id3
sort mol_id3 > mol_id4
mv mol_id4 mol_id


grep -w -f mol_id desc_train > common_desc1 #file with more number of molecules
sort common_desc1 > common_desc
sed 's/,/ /g' common_desc > common_desc2
./transpose.awk common_desc2 > common_desc3
sed '1d' common_desc3 > common_desc4
./transpose.awk common_desc4 > common_desc_without_molid1 #don't delete this file because it is used in common molecule id selection step
sed 's/ /,/g' common_desc_without_molid1 > common_desc_without_molid
#sort TrainingFP_top10per > common_descriptors

# common molecule id selection

#./transpose.awk TrainingFP_top10per > TrainingFP_top10per2

sed '/Name/d' TrainingFP_top10per1 > TrainingFP_top10per19
sort TrainingFP_top10per19 > TrainingFP_top10per110
#sed 's/,/ /g' TrainingFP_top10per110 > TrainingFP_top10per111
./transpose.awk TrainingFP_top10per110 > TrainingFP_top10per112
sed '$d' TrainingFP_top10per112 > TrainingFP_top10per113
./transpose.awk TrainingFP_top10per113 > TrainingFP_top10per114
sed 's/ /,/g' TrainingFP_top10per114 > Training_fp_withoutfac
#head -1 TrainingFP_top10per2 > common_mol2
#sed 's/ /\n/g' common_mol2 > common_mol
#grep -w -f common_mol TrainingFP_top10per > common_desc9
#sort common_desc9 > common_desc
#sed 's/,/ /g' common_desc > common_desc1
#./transpose.awk common_desc1 > common_desc2
#sed '1d' common_desc2 > common_desc3
#./transpose.awk common_desc3 > common_desc4
#sed 's/ /,/g' common_desc4 > common_desc5
#mv common_desc5 common_desc_without_mol_id


# Creating hybrid file

paste Training_fp_withoutfac common_desc_without_molid > hybrid2
sed 's/\t/,/g' hybrid2 > hybrid1
sort -R hybrid1 > hybrid3

# putting the common_header

head -1 TrainingFP_top10per > header_fp1
sed 's/,/\n/g' header_fp1 > header_fp2
sed '/Factor/d' header_fp2 > header_fp3
./transpose.awk header_fp3 > header_fp4
sed 's/ /,/g' header_fp4 > header_fp
head -1 desc_train > header_desc1
sed 's/,/\n/g' header_desc1 > header_desc2
sed '/Name/d' header_desc2 > header_desc3
./transpose.awk header_desc3 > header_desc4
sed 's/ /,/g' header_desc4 > header_desc
paste header_fp  header_desc > header1
sed 's/\t/,/g' header1 > header
cat header hybrid3 > hybrid

#rm mol_id1 mol_id2 mol_id3 TrainingFP_top10per1 TrainingFP_top10per2 common_desc1 common_desc2 common_desc3 common_desc_without_fac2 common_mol2 common_desc9 common_desc1 common_desc2 common_desc3 common_desc4 hybrid2 hybrid1 header_desc1 header_desc2 header_desc3 header_desc4 header_desc header_desc1 header_desc2 header_desc3 header_desc4 header_desc header1 hybrid3 common_desc_without_fac1 common_desc common_desc_fac common_mol header mol_id


#sed '$d' filename.txt ( to remove last line)
#sed '1d' filename ( to remove first line)

