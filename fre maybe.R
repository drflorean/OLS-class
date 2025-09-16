#### like "fre"

issp_reg %>% group_by(female) %>% count() %>%
  ungroup %>% mutate(prop = n/sum(n))## like "fre"
## SMALL TABLE WITH COUNT AND PROPORTION  

### define the function that does this
fre <- function(x,y){x %>% group_by(y) %>% count() %>%
    ungroup %>% mutate(prop = n/sum(n))}
fre(issp_reg, female)

