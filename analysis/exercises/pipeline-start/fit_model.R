# Step 2 of 4. Fits a Cox model of time to vision loss and writes it.
# Run from this directory: Rscript fit_model.R

library(survival)

cleaned <- readRDS('cleaned.rds')

# Each patient contributes two eyes, so the robust standard errors
# cluster on the patient identifier.
model <- coxph(Surv(time, status) ~ arm + age, data = cleaned,
               cluster = id)

saveRDS(model, 'model.rds')
