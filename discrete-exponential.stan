data {
  int<lower=1> N;
  array[N] int<lower=1> y;  // observed durations
  int<lower=1> k_min;
  int<lower=1> k_max;       // for zeta approx
}

transformed data {
  int K = k_max - k_min + 1;
  vector[K] k_vals;
  for (i in 1:K) {
    k_vals[i] = k_min + i - 1;
  }
}

parameters {
  real alpha;   // exponent
}

model {
  real zeta_approx = 0;
  for (i in 1:K)
    zeta_approx += exp(-k_vals[i] * alpha);

  for (i in 1:N) {
    target += -alpha * y[i] - log(zeta_approx);
  }

  // alpha ~ normal(2, 1);
}
