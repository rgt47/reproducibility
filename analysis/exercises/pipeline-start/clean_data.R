# Step 1 of 4. Reads the raw extract and writes the cleaned data.
# Run from this directory: Rscript clean_data.R

raw <- read.csv('data/raw_data.csv')

cleaned <- raw
cleaned$arm <- factor(cleaned$trt, levels = c(0, 1),
                      labels = c('Untreated', 'Laser'))
cleaned <- cleaned[!is.na(cleaned$time), ]

saveRDS(cleaned, 'cleaned.rds')
