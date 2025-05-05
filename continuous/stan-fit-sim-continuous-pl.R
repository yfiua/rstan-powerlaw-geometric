sim_power <- function(N, alpha, beta, r, delta = 0, sdlog = 1) {
  delta + rlnorm(length(N), log(alpha + beta * N^(-r)), sdlog)
}

set.seed(1)
n <- 3000
ns <- seq(n)
xp <- sim_power(ns, 1, 2, 1, .3, .05)

# save the data as csv
write.csv(xp, "simulated_data_continuous.csv", row.names = FALSE)


library(rstan)

# options for rstan
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# read stan model
stan_model <- stan_model("continuous-powerlaw.stan")

# fit power model data
fit_pp <- sampling(
  stan_model,
  data = list('y' = xp, 'n' = n),
  refresh = FALSE, chains = 4, iter = 8000, seed = 1
)


# print the results (eta, c)
print(fit_pp, pars = c("alpha", "r"))

# a nicer summary
library(bayesplot)
posterior <- as.matrix(fit_pp)
mcmc_hist(posterior, pars = c("alpha", "r")) # for example
