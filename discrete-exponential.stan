data {
  int<lower=1> N;
  array[N] int<lower=1> y;  // observed durations
  int<lower=1> k_min;
  int<lower=1> k_max;       // for zeta approx
}

parameters {
  real p;   // probability of contact continuing
}

model {
  for (i in 1:N) {
    target += log(p ^ (y[i] - 1) * (1 - p));
  }
}
