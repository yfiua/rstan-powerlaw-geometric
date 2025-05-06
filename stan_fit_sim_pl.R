library(rstan)
library(readr)
library(bayesplot)

# options for rstan
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# read data
synthetic_data <- read_csv("synthetic_data_pl.csv")

stan_data <- list(N = nrow(synthetic_data),
                  y = synthetic_data$x,
                  k_min = 1,
                  k_max = max(synthetic_data$x))

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

# print the results
print(fit, pars = c("alpha"))

# a nicer summary
posterior <- as.matrix(fit)
mcmc_hist(posterior, pars = c("alpha"))
