library(rstan)
library(readr)

# options for rstan
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# read data
data <- read_csv("synthetic_data_pl.csv")

stan_data <- list(
  n = nrow(data),
  y = data$tau
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
print(fit, pars = c("alpha", "r"))

# a nicer summary
library(bayesplot)
posterior <- as.matrix(fit)
mcmc_hist(posterior, pars = c("alpha", "r")) # for example
