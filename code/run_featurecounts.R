# Load R libs ####
library(Rsubread)


# Read metadata ####
info <- read.csv(
  "/storage/thinc/projects/resources/sra/SRP425509/SraRunTable.csv")


# Define files ####
files <- system(
  "ls /storage/thinc/projects/resources/sra/SRP425509/bam/*bam",
  intern = T)

#files <- sample(files, 3)

samples <- basename(files)
samples <- gsub("_1_preprocessed.bam", "", fixed = T, samples)

info <- info[match(samples, info$Run), ]


# Run featureCounts ####
bulk <- which(info$LibrarySource == "TRANSCRIPTOMIC")
fc_bulk <- featureCounts(files[bulk], annot.inbuilt = "hg38", isPairedEnd = T)

sc <- which(info$LibrarySource == "TRANSCRIPTOMIC SINGLE CELL")
fc_sc <- featureCounts(files[sc], annot.inbuilt = "hg38", isPairedEnd = T)


# Save data ####
save(
  info, fc_bulk, fc_sc, 
  file = "/storage/thinc/projects/resources/sra/SRP425509/fc_counts.RData")

