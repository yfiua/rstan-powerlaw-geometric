library(rstan)
library(readr)
library(bridgesampling)

# options for rstan
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# read data
synthetic_data <- read_csv("data/synthetic_data_pl.csv")

stan_data <- list(N = nrow(synthetic_data),
                  y = synthetic_data$x,
                  k_min = 1,
                  k_max = max(synthetic_data$x))

# read stan models
stan_model_pl <- stan_model("discrete-powerlaw.stan")
stan_model_exp <- stan_model("discrete-exponential.stan")

# fit the models
fit_pl <- sampling(
  stan_model_pl,
  data = stan_data,
  iter = 2000,
  chains = 4,
  seed = 123
)

fit_exp <- sampling(
  stan_model_exp,
  data = stan_data,
  iter = 2000,
  chains = 4,
  seed = 123
)

# calculate bayes factor
bayes_factor(
  bridge_sampler(fit_pl, silent = TRUE),
  bridge_sampler(fit_exp, silent = TRUE)
)
