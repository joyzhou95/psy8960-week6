# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(stringr)
library(tidyverse)
library(rebus)

# Data Import
citations <- stri_read_lines("../data/citations.txt", encoding = "Windows-1258")
citation_txt <- citations[!stri_isempty(citations)]
length(citations) - length(citation_txt)
mean(str_length(citation_txt))

# Data Cleaning
sample(citation_txt, 10)

citation_tbl <- tibble(lines = 1:length(citation_txt), cite = citation_txt) %>%
  mutate(cite = str_replace_all(string = cite, pattern = "\"|'", replacement = "")) %>%
  mutate(year = str_match(cite, pattern = '\\((\\d+)\\)')[,2]) %>%
  mutate(page_start = str_match(cite, pattern = '\\s(\\d+)-')[,2]) %>%
  mutate(perf_ref = str_detect(cite, pattern = fixed("performance", ignore_case = T))) %>%
  mutate(title = str_match(cite, pattern = '\\(\\d+\\)\\.\\s([^\\.]+[\\(\\w\\)\\.]+)\\s')[,2]) %>%
  mutate(first_author = str_match(cite, pattern = '^[A-Za-z-]+,\\s[A-Z]\\.\\s?[A-Z]?\\.?'))

sum(!is.na(citation_tbl$first_author))
