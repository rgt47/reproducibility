# Step 3 of 4. Builds the survival curves by arm and writes the figure.
# Run from this directory: Rscript make_figures.R

library(survival)
library(ggplot2)

cleaned <- readRDS('cleaned.rds')
model <- readRDS('model.rds')

hr <- exp(coef(model))[['armLaser']]
curves <- survfit(Surv(time, status) ~ arm, data = cleaned)
steps <- data.frame(
  time = curves$time,
  surv = curves$surv,
  arm = rep(sub('arm=', '', names(curves$strata)), curves$strata)
)

# The figure is saved as a ggplot object, not an image file, so that
# a change to it is a change to a value a later step reads.
figures <- ggplot(steps, aes(time, surv, linetype = arm)) +
  geom_step() +
  labs(x = 'Months', y = 'Free of vision loss', linetype = NULL,
       title = sprintf('Hazard ratio, laser vs untreated: %.2f', hr))

saveRDS(figures, 'figures.rds')
