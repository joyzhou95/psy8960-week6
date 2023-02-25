# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(stringr)
library(tidyverse)
library(rebus)

# Data Import
citations <- stri_read_lines("../data/citations.txt", encoding = "Windows-1258")
citation_txt <- str_emp(citations, pattern = ".+")
length(citations) - length(citation_txt)
mean(str_length(citation_txt))

# Data Cleaning
sample(citation_txt, 10)
head(citation_txt, 20)
citation_tbl <- tibble(lines = 1:length(citation_txt), cite = citation_txt) %>%
  mutate(cite = str_replace_all(string = cite, pattern = "\"|'", replacement = "")) %>%
  mutate(year = str_match(cite, pattern = '\\((\\d+)\\)')[,2]) %>%
  mutate(page_start = str_match(cite, pattern = '\\s(\\d+)-')[,2]) %>%
  mutate(perf_ref = str_detect(cite, pattern = '[Pp]erformance|PERFORMANCE')) 

