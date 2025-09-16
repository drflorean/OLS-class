rm(list=ls())

libraries <- c("tidyverse", "haven", "rio")

installed_libs <- libraries %in% rownames(installed.packages())
if (any(installed_libs==FALSE)) {
  install.packages(libraries[!installed_libs])
}

lapply(libraries, library, character.only=T)

issp_df <- read_dta("issp2009ger.dta")
View(issp_df)
names(issp_df)

### description ---------
table(issp_df$incdiff100)

dtab <- issp_df %>% summarise(
  mean = mean(incdiff100, na.rm=T),
  median = median(incdiff100, na.rm=T),
  min = min(incdiff100, na.rm=T),
  max = max(incdiff100, na.rm=T))
View(dtab)

### Linear regression -------------
issp_reg <- issp_df %>% select(incdiff100, procjust) %>% drop_na()

reg1 <- lm(incdiff100~procjust, data = issp_reg)  ## Y ~ X, data=dataset
reg1 ## VEEEERY basic output
summary(reg1) ### Better output but not as good as stata :(
