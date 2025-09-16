rm(list=ls())

libraries <- c("tidyverse", "haven", "rio", "texreg", "labelled")

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


ctab <- issp_reg %>% group_by(midclass) %>% count()
ctab <- ctab %>% ungroup %>% mutate(prop = n/sum(n)) ## like "fre"
## SMALL TABLE WITH COUNT AND PROPORTION  



### Linear regression -------------
issp_reg <- issp_df %>% select(incdiff100, procjust, midclass, female) %>% drop_na()
unique(issp_reg$midclass) ## midclass dummy variable

# continuous variables only
reg1 <- lm(incdiff100~procjust, data = issp_reg)  ## Y ~ X, data=dataset
reg1 ## VEEEERY basic output
summary(reg1) ### Better output but not as good as stata :(
screenreg(reg1)

# with dummy X variable
reg2 <- lm(incdiff100~midclass, data = issp_reg)
summary(reg2)
screenreg(reg2)

reg3 <- lm(incdiff100~female, data = issp_reg)
screenreg(reg3)

### with categorical variables
issp_reg <- issp_df %>% select(incdiff100, procjust, midclass, female, educ3, mobility3) %>% drop_na()
class(issp_reg$educ3)
unique(issp_reg$educ3)

## R can deal with categorical variables by itself when they are declared as factor
issp_reg <- issp_reg %>% mutate(mobil3f = labelled::to_factor(mobility3)) 
issp_reg %>% group_by(mobil3f) %>% count() %>% ungroup %>% mutate(prop = n/sum(n)) ## like "fre"

reg4 <- lm(incdiff100 ~ mobil3f, data = issp_reg)

## relevel() changes the reference category of the factor
issp_reg <- issp_reg %>% mutate(mobilfactor = relevel(issp_reg$mobil3f, "Immobil"))
reg4 <- lm(incdiff100~mobilfactor, data = issp_reg)
screenreg(reg4)
