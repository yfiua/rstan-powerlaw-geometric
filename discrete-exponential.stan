data {
  int<lower=1> N;           // number of observations
  array[N] int<lower=1> y;  // observations
}

parameters {
  real p;
}

model {
  for (i in 1:N) {
    target += log1m(p) * (y[i] - 1) + log(p);
  }
}
