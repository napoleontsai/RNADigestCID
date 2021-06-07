# RNADigestCID
RNADigestCID is a pipeline that can calculate post-RNase digestion RNA sequences and mass. It can further calculate RNA fragment sequences and mass generated by
collision-induced dissociation (CID). To run RNADigestCID, install R then download string manipulation packages "seqinr" and "stringr".
To start, create a blank txt file named "FindDirect.txt".
Paste “FindDirect.txt” file path into the code line containing read.table(“ ”).
Create an output folder and paste the folder path into the code line containing write.csv(“output folder path / std_out_( ).csv“).

# Calculate post-RNase digested RNA sequences and mass
Download and save RNA sequence to be analyzed in fasta format.
Copy and paste fasta file path into the first line of FindDirect.txt.
In terminal, establish path to R scripts and type: Rscript RNase( ).R
The csv file with post-RNase digested sequences and mass will be saved into the output folder.

# Calculate CID fragmentation RNA sequences and mass
Copy and paste post-RNase digested sequence csv file path into the second line of FindDirect.txt.
In terminal, establish path to R scripts and type: Rscript CID_( ).R
The csv file with CID fragmentation RNA sequences and mass will be saved into the output folder.

# Calculate CID fragments mass after base loss
Copy and paste CID fragmentation RNA sequence csv file path into the third line of FindDirect.txt.
In terminal, establish path to R scripts and type: Rscript CID_a-B.R
The csv file with CID base loss RNA sequences and mass will be saved into the output folder.
