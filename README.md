# rstan-powerlaw-geometric

Distinguish power-law and geometric (discrete exponential) distributions using RStan with bridge sampling.

## Synthetic data

* [sim_pl.R](sim_pl.R): generate synthetic data [synthetic_data_pl.csv](synthetic_data_pl.csv) that exhibits power-law with exponent $-2$
* [sim_exp.R](sim_exp.R): generate synthetic data [synthetic_data_exp.csv](synthetic_data_exp.csv) that exhibits geometric distribution with $p=.2$

## Model fitting

* [discrete-powerlaw.stan](discrete-powerlaw.stan): Stan model for discrete power-law distribution
* [discrete-exponential.stan](discrete-exponential.stan): Stan model for geometric distribution
* [stan_fit_sim_pl.R](stan_fit_sim_pl.R): fit the power-law model with `synthetic_data_pl.csv`
* [stan_fit_sim_exp.R](stan_fit_sim_exp.R): fit the geometric model with `synthetic_data_exp.csv`

## Model comparison

* [model-comparison.R](model-comparison.R): compute the Bayes factor of the two models using bridge sampling

## References

* https://fabiandablander.com/r/Law-of-Practice.html 
