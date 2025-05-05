// In the data block, we specify everything that is relevant for
// specifying the data. Note that PRIOR_ONLY is a dummy variable used later.
 
data {
  int<lower=1> n;
  real y[n];
}
 
 
// In the parameters block, we specify all parameters we need.
// Although Stan implicitly adds flat priors on the (positive) real line
// we will specify informative priors below.
 
parameters {
  real<lower=0> r;
  real<lower=0> alpha;
  real<lower=0> beta;
  real<lower=0> sigma_e;
}
 
// In the model block, we specify our informative priors and
// the likelihood of the model, unless we want to sample only from
// the prior (i.e., if PRIOR_ONLY == 1)
 
model {
  target += lognormal_lpdf(alpha | 0, .5);
  target += lognormal_lpdf(beta | 1, .5);
  target += gamma_lpdf(r | 1, 3);
  target += gamma_lpdf(sigma_e | 0.5, 5);
 
  for (trial in 1:n) {
    target += normal_lpdf(y[trial] | alpha + beta * trial^(-r), sigma_e);
  }
}
 
// In this block, we make posterior predictions (ypred) and compute
// the log likelihood of each data point (log_lik)
// which is needed for the computation of loo later
 
generated quantities {
  real ypred[n];
  real log_lik[n];
 
  for (trial in 1:n) {
    ypred[trial] = normal_rng(alpha + beta * trial^(-r), sigma_e);
    log_lik[trial] = normal_lpdf(y[trial] | alpha + beta * trial^(-r), sigma_e);
  }
 
}
