library(rstan)
library(readr)

# options for rstan
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# generate data
synthetic_data <- rpldis(n = 5000,
                         xmin = 1,
                         alpha = 2)

# save data
write.csv(synthetic_data, "synthetic_data_pl.csv", row.names = FALSE)

stan_data <- list(
  N = nrow(synthetic_data),
  y = synthetic_data,
  k_min = 1,
  k_max = max(synthetic_data)
)

# read stan model
stan_model <- stan_model("discrete-powerlaw.stan")

# fit the model
fit <- sampling(
  stan_model,
  data = stan_data,
  iter = 2000,
  chains = 4,
  seed = 123
)

# print the results (eta, c)
print(fit, pars = c("alpha"))

# a nicer summary
library(bayesplot)
posterior <- as.matrix(fit)
mcmc_hist(posterior, pars = c("alpha"))
