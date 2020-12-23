A1 = read.table(file="../FPTraining_top10per", header=T, sep=",", row.names = 1)
# When you know the varibales belonging to a particular group
# Name,HeavyAtomMolWt,MaxAbsEStateIndex,MaxEStateIndex,ExactMolWt,MolWt,NumValenceElectrons,MinEStateIndex,MinAbsEStateIndex,BalabanJ,BertzCT,Chi0,Chi0n,Chi0v,Chi1,Chi1n,Chi1v,Chi2n,Chi2v,Chi3n,Chi3v,Chi4n,Chi4v,HallKierAlpha,Kappa1,Kappa2,Kappa3,LabuteASA,PEOE_VSA1,PEOE_VSA10,PEOE_VSA14,PEOE_VSA2,PEOE_VSA3,PEOE_VSA4,PEOE_VSA6,PEOE_VSA7,PEOE_VSA8,PEOE_VSA9,SMR_VSA1,SMR_VSA10,SMR_VSA2,SMR_VSA3,SMR_VSA4,SMR_VSA5,SMR_VSA6,SMR_VSA7,SMR_VSA9,SlogP_VSA1,SlogP_VSA11,SlogP_VSA12,SlogP_VSA2,SlogP_VSA3,SlogP_VSA4,SlogP_VSA5,SlogP_VSA6,TPSA,EState_VSA1,EState_VSA10,EState_VSA2,EState_VSA3,EState_VSA4,EState_VSA5,EState_VSA6,EState_VSA7,EState_VSA8,EState_VSA9,VSA_EState10,VSA_EState8,VSA_EState9,FractionCSP3,HeavyAtomCount,NHOHCount,NOCount,NumAliphaticCarbocycles,NumAliphaticHeterocycles,NumAliphaticRings,NumAromaticCarbocycles,NumAromaticRings,NumHAcceptors,NumHDonors,NumHeteroatoms,NumRotatableBonds,RingCount,MolLogP,MolMR,fr_Al_COO,fr_Al_OH,fr_Al_OH_noTert,fr_COO,fr_COO2,fr_C_O_noCOO,fr_NH0,fr_NH1,fr_allylic_oxid,fr_benzene,fr_bicyclic,fr_ether,fr_halogen,fr_phos_acid,fr_phos_ester,fr_quatN,Factor
# 239.sdf,424.9,9.3,9.3,437.9,439,108,0,0,0,570.9,13.1,10.2,15.6,8.6,5.1,12.2,3.7,11.1,2.3,10.8,1.3,8.5,-0.7,19.3,8.6,5,139.9,0,0,115.9,0,0,0,0,0,0,0,10.2,71.2,0,0,0,0,11.5,36.4,11.5,20.2,11.5,24.8,36.5,0,0,0,36.4,92.5,0,10.2,62.6,11.4,0,8.7,12.1,24.3,0,11.5,0,2.4,41.8,0,20,6,4,0,0,0,2,2,4,4,8,2,2,0.4,90.3,0,0,0,0,0,0,0,0,0,2,0,0,2,0,0,0,T
# CHEBI_57566.mol,293.1,11.6,11.6,305,305.2,112,-5.1,0,2.1,585.1,14.9,10.1,11,9.3,5.6,7.1,4.2,5.4,2.8,3.2,1.8,2.2,-1.3,15.1,5.6,3.6,112.6,34.5,18.1,5.7,4.6,4.8,5,0,6.1,12.6,20.5,28.7,13.6,0,9.6,0,24.9,12.3,22.7,0,21.2,0,7.8,33.5,13.8,0,12.6,17.1,162.8,38.6,24.3,12.2,0,4.6,12.3,0,0,9.5,10.5,0,15.5,49.6,0.6,20,3,10,0,1,1,0,1,10,2,11,4,2,-2.7,61,0,1,1,0,0,0,2,0,0,0,0,1,0,1,1,0,NT
# HMDB06351.mol,378.3,12.1,12.1,425.4,425.7,176,-1.1,0.1,3.6,468.3,22.7,20.1,20.1,14.3,12.1,12.1,9.3,9.3,5.4,5.4,3.4,3.4,-1.4,28.6,18.4,18.7,185,14.6,0,6,9.3,0,0,70.4,38.5,18.8,21.1,23.9,11.9,0,0,0,115.9,21.1,12.2,0,5.1,0,0,43.8,14.3,0,109.7,12.2,66.4,12.2,14.7,18.8,10.9,19.3,64.2,0,21.1,19.1,4.7,0,0.4,66.3,0.8,30,0,5,0,0,0,0,0,4,0,5,20,0,5.1,121.6,1,0,0,1,1,2,1,0,2,0,0,1,0,0,0,1,NT

a <- nrow(A1)
b <- ncol(A1)
#Location <- a$Location
text = c("Variable", "P-value", "Mean_Group1", "Mean_Group2")
write.table(t(text), file="Wilcox", col.names = F, sep="\t", row.names = F, quote = F)
for (i in 1:1020)
{
# To use variables belongs to one group when rows information is not known
  X = split(A1, A1$Factor)
  c = as.numeric(X[[1]][, i])
  d = as.numeric(X[[2]][, i])

# To use variables belongs to one group when rows information is present
# c = as.numeric(A1[1:6, i])
# d = as.numeric(A1[7:12, i])
  
  test = wilcox.test(c,d, paired = F, alternative = c("two.sided", "less", "greater"))
  if (test$p.value < 0.01)
  {
    val=data.frame(colnames(A1[i]), test$p.value, mean(c), mean(d))
    write.table(val, file = "Wilcox", append = T, quote = F, sep="\t", row.names = F, col.names = F)
  }
}

# It is important to calculate c and d by using Levels from the file itself