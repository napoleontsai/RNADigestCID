
# Calculate all internal fragments
library(stringr)
library(seqinr)
library(rstudioapi)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # Automatically set work directory
print(getwd())

rnase.digested.fragments <- read.csv(as.character(read.table("FileDirect.txt")$V1[2]),header = TRUE) # FileDirect.txt file path
internal.sequences <- substring(rnase.digested.fragments$Digested_Sequence[which(str_count(rnase.digested.fragments$Digested_Sequence)>3)],2,str_count(rnase.digested.fragments$Digested_Sequence[which(str_count(rnase.digested.fragments$Digested_Sequence)>3)])-1)
cid.frag.array <- list()
for (i in 1:length(internal.sequences)){
  cid.frag <- list()
  for (j in 1:str_count(internal.sequences[i])){
    cid.frag[[j]] <- substring(as.character(internal.sequences[i]),j,c(j+1:str_count(internal.sequences[i])))
  }
  cid.frag.array[[i]] <- cid.frag
}
cid.frag.array <- sapply(sapply(cid.frag.array,unlist),unique)
internal.frag <- unlist(cid.frag.array)[which(str_count(unlist(cid.frag.array))>1)]

# Calculate internal fragments mass
mass_A <- list()
mass_G <- list()
mass_C <- list()
mass_U <- list()
wa_ions_mass <- list()
for (i in 1:length(internal.frag)){
  mass_A[[i]] <- str_count(internal.frag[[i]],"A")*329.2
  mass_G[[i]] <- str_count(internal.frag[[i]],"G")*345.2
  mass_C[[i]] <- str_count(internal.frag[[i]],"C")*305.2
  mass_U[[i]] <- str_count(internal.frag[[i]],"T")*306.2
  wa_ions_mass[[i]] <- mass_A[[i]] + mass_C[[i]] + mass_G[[i]] + mass_U[[i]] + 79 - 79
}
wa.ions.frag.mass <- cbind(internal.frag,unlist(wa_ions_mass))
colnames(wa.ions.frag.mass) <- c("w-a_fragments","Mass_Da")
write.csv(wa.ions.frag.mass, 'std_out_wa_ions.csv') # Output spreadsheet
q()
