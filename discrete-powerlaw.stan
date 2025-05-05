data {
  int<lower=1> n;
  int y[n];
}

parameters {
  real<lower=0> r;
  real<lower=0> alpha;
  real<lower=0> beta;
  real<lower=0> sigma_e;
}

model {
  target += lognormal_lpdf(alpha | 0, .5);
  target += lognormal_lpdf(beta | 1, .5);
  target += gamma_lpdf(r | 1, 3);
  target += gamma_lpdf(sigma_e | 0.5, 5);

  for (trial in 1:n) {
    target += normal_lpdf(y[trial] | alpha + beta * trial^(-r), sigma_e);
  }
}

generated quantities {
  real ypred[n];
  real log_lik[n];

  for (trial in 1:n) {
    ypred[trial] = normal_rng(alpha + beta * trial^(-r), sigma_e);
    log_lik[trial] = normal_lpdf(y[trial] | alpha + beta * trial^(-r), sigma_e);
  }
}
