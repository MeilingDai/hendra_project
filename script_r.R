.libPaths(c("C:/Users/DAI035/data_school/Packages"))

library(tidyverse)
sessionInfo()


read_csv("data/field_horses_metadata.csv")
field_horses_metadata <- read_csv("data/field_horses_metadata.csv")
field_horses_metadata


#read csv data
read_csv("data/field_horses_raw_counts.csv")
field_horses_raw_counts <- read_csv("data/field_horses_raw_counts.csv")
field_horses_raw_counts


tidy_field_horses_raw_counts <-  field_horses_raw_counts %>%  
  gather(key = horse_id, value = counts, -gene) %>% 
  spread(key = gene, value = counts ) %>% 
  gather(key = gene, value = counts, - horse_id)

tidy_field_horses_raw_counts 



full_data <- full_join(tidy_field_horses_raw_counts, field_horses_metadata)

full_data

ggplot (data = full_data,
        aes(x = gene,y = counts, color = horse_id, shape = infection),
        geom_point())
