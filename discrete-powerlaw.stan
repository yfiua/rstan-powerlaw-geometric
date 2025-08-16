data {
  int<lower=1> N;
  array[N] int<lower=1> y;  // observed durations
}

parameters {
  real alpha;   // exponent
}

transformed parameters {
  // estimate the zeta function for alpha
  real zeta_approx = 0;
  for (i in 1:1000)
    zeta_approx += pow(i, -alpha);
}

model {
  // target
  target += -alpha * sum(log(to_vector(y))) - N * log(zeta_approx);

  // alpha ~ normal(2, 1);
}
