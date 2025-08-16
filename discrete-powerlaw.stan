data {
  int<lower=1> N;
  array[N] int<lower=1> y;  // observed durations
}

parameters {
  real alpha;   // exponent
}

transformed parameters {
  // estimate the zeta function for alpha using Kahan summation
  real zeta_approx;
  {
    real sum = 0;
    real c = 0;   // compensation
    for (i in 1:1000) {
      real term = exp(-alpha * log(i));  // numerically stable version of pow(i, -alpha)
      real y_k = term - c;
      real t = sum + y_k;
      c = (t - sum) - y_k;
      sum = t;
    }
    zeta_approx = sum;
  }
}

model {
  // target
  target += -alpha * sum(log(to_vector(y))) - N * log(zeta_approx);

  // alpha ~ normal(2, 1);
}
