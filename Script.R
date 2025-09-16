rm(list=ls())

libraries <- c("tidyverse", "haven", "rio")

installed_libs <- libraries %in% rownames(installed.packages())
if (any(installed_libs==FALSE)) {
  install.packages(libraries[!installed_libs])
}

lapply(libraries, library, character.only=T)

issp_df <- read_dta("issp2009ger.dta")
View(issp_df)
