#!/usr/bin/env Rscript
# Calculate all possible CID fragments
library(stringr)
library(seqinr)

dir <- print(getwd())
setwd(dir) # Automatically set work directory

rnase.digested.fragments <- read.csv(as.character(read.table("FileDirect.txt")$V1[2]),header = TRUE) # FileDirect.txt file path
cid.frag.array <- list()
for (i in 1:nrow(rnase.digested.fragments)){
  cid.frag <- list()
  for (j in 1:str_length(rnase.digested.fragments$Digested_Sequence[i])){
    cid.frag[[j]] <- substring(as.character(rnase.digested.fragments$Digested_Sequence[i]),j,c(j:str_length(rnase.digested.fragments$Digested_Sequence[i])))
  }
  cid.frag.array[[i]] <- cid.frag
}
cid.frag.array <- sapply(cid.frag.array,unlist)

# Select d-z ions
d.ions <- list()
for (i in 1:length(cid.frag.array)){
  d.ions[[i]] <- cid.frag.array[[i]][1:max(str_count(cid.frag.array[[i]]))-1]
}
z.ions <- list()
for (i in 1:nrow(rnase.digested.fragments)){
  z.ions[[i]] <- substring(rnase.digested.fragments$Digested_Sequence[i],c(2:str_count(rnase.digested.fragments$Digested_Sequence[i])))
}
d.ions <- unlist(d.ions[which(str_count(rnase.digested.fragments$Digested_Sequence) > 1)])
z.ions <- unlist(z.ions[which(str_count(rnase.digested.fragments$Digested_Sequence) > 1)])

# Calculate d-z ion fragments mass
mass_A <- list()
mass_G <- list()
mass_C <- list()
mass_U <- list()
d_ions_mass <- list()
for (i in 1:length(d.ions)){
  mass_A[[i]] <- str_count(d.ions[[i]],"A")*329.0525
  mass_G[[i]] <- str_count(d.ions[[i]],"G")*345.0474
  mass_C[[i]] <- str_count(d.ions[[i]],"C")*305.0413
  mass_U[[i]] <- str_count(d.ions[[i]],"T")*306.0253
  d_ions_mass[[i]] <- mass_A[[i]] + mass_C[[i]] + mass_G[[i]] + mass_U[[i]] + 1.007825035 + 15.99491463
}
d.ions.frag.mass <- cbind(d.ions,unlist(d_ions_mass))

mass_A <- list()
mass_G <- list()
mass_C <- list()
mass_U <- list()
z_ions_mass <- list()
for (i in 1:length(z.ions)){
  mass_A[[i]] <- str_count(z.ions[[i]],"A")*329.0525
  mass_G[[i]] <- str_count(z.ions[[i]],"G")*345.0474
  mass_C[[i]] <- str_count(z.ions[[i]],"C")*305.0413
  mass_U[[i]] <- str_count(z.ions[[i]],"T")*306.0253
  z_ions_mass[[i]] <- mass_A[[i]] + mass_C[[i]] + mass_G[[i]] + mass_U[[i]] + 17.00274 - 15.99491463
}
z.ions.frag.mass <- cbind(z.ions,unlist(z_ions_mass))
colnames(d.ions.frag.mass) <- c("d_fragments","Mass_Da")
colnames(z.ions.frag.mass) <- c("z_fragments","Mass_Da")

DigestionType <- as.character(read.table("FileDirect.txt")$V1[2])
tag <- unlist(str_split(DigestionType, "out_"))[2]
OutputNameOne <- paste("std_out_d_ions", tag, sep = "_")
OutputNameTwo <- paste("std_out_z_ions", tag, sep = "_")
write.csv(d.ions.frag.mass, OutputNameOne) # Output spreadsheet
write.csv(z.ions.frag.mass, OutputNameTwo) # Output spreadsheet
q()