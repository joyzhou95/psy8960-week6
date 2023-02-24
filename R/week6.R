# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(stringr)



# Data Import
citations <- stri_read_lines("../data/citations.txt", encoding = "Windows-1258")
citation_txt <- str_subset(citations, pattern = ".")
length(citations) - length(citation_txt)
sum(str_length(citation_txt))/length(citation_txt)

# Data Cleaning
sample(citation_txt, 10)

