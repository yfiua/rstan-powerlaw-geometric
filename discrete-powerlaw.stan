data {
  int<lower=1> N;           // number of observations
  array[N] int<lower=1> y;  // observations
}

transformed data {
  int K = 1000;
  vector[K] logk;
  for (k in 1:K)
    logk[k] = log(k);
}

parameters {
  real alpha;   // power-law exponent
}

transformed parameters {
  // estimate the log zeta function using the first K terms
  real log_zeta_approx = log_sum_exp(-alpha * logk);
}

model {
  // target
  target += -alpha * sum(log(to_vector(y))) - N * log_zeta_approx;

  // priors
  // alpha ~ normal(2, 1);
}
