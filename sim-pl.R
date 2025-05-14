library(poweRlaw)

# generate data
synthetic_data <- rpldis(n = 5000,
                         xmin = 1,
                         alpha = 2)

# save data
write.csv(synthetic_data, "data/synthetic_data_pl.csv", row.names = FALSE)
