.libPaths(c("C:/Users/DAI035/data_school/Packages"))

library(tidyverse)
sessionInfo()



read_csv("data/field_horses_metadata_modified.csv")
field_horses_metadata_modified <- read_csv("data/field_horses_metadata_modified.csv")
field_horses_metadata_modified 

#read csv data
read_csv("data/field_horses_raw_counts_modified.csv")
field_horses_raw_counts_modified <- read_csv("data/field_horses_raw_counts_modified.csv")
field_horses_raw_counts_modified 


tidy_field_horses_raw_counts <-  field_horses_raw_counts_modified %>%  
  gather(key = horse_id, value = counts, -gene) 
tidy_field_horses_raw_counts

full_data <- full_join(tidy_field_horses_raw_counts, field_horses_metadata_modified)

full_data 


numeric_full_data <-  full_data %>% 
  separate(col = gene, into = c("gene_cluster1", "gene_cluster2"), sep = "_" ) %>% 
  mutate (gene_cluster1 = as.numeric(gene_cluster1), gene_cluster2 = as.numeric(gene_cluster2)) %>% 
  filter(gene_cluster2 != "NA")
  


numeric_full_data



numeric_full_data_plot <- ggplot (data = numeric_full_data,
        aes(x = gene_cluster2,
            y = counts, 
            color = horse_id,
            group = gene_cluster2))+
        geom_point()+
  scale_y_continuous(limits = c(0, 1000))+
  scale_color_manual(values = c("grey", "black", "darkgrey", "red","blue","green"))+
  facet_wrap(~ horse_id) 
ggsave(filename = "results/Figure 3.png", plot = numeric_full_data_plot, width = 10, height = 8, dpi = 300, units = "cm")

  
numeric_full_data_plot <- ggplot (data = numeric_full_data,
                                  aes(x = gene_cluster2,
                                      y = counts, 
                                      color = horse_id,
                                      group = gene_cluster1))+
  geom_point()+
  scale_y_continuous()+
  scale_color_manual(values = c("grey", "black", "darkgrey", "red","blue","green"))+
  facet_wrap(~ horse_id) 

ggsave(filename = "results/Figure 4.png", plot = numeric_full_data_plot, width = 10, height = 8, dpi = 300, units = "cm")
