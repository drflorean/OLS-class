#### like "fre"

ctab <- issp_reg %>% group_by(midclass) %>% count()
ctab <- ctab %>% ungroup %>% mutate(prop = n/sum(n)) ## like "fre"
## SMALL TABLE WITH COUNT AND PROPORTION  

### define the function that does this

