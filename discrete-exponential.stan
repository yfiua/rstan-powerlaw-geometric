data {
  int<lower=1> N;
  array[N] int<lower=1> y;  // observed durations
}

parameters {
  real p;
}

model {
  for (i in 1:N) {
    target += log1m(p) * (y[i] - 1) + log(p);
  }
}
