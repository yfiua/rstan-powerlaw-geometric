# params
N <- 5000
p <- 0.8  # probability of contact continuing

# Generate tau ~ Geometric(p)
# Note: In R, rgeom() gives number of failures BEFORE first success (0,1,2,...)
# So we add 1 to match the Stan model (tau >= 1)
synthetic_data <- rgeom(N, prob = 1 - p) + 1

# save data
write.csv(synthetic_data, file = "synthetic_data_exp.csv", row.names = FALSE)
