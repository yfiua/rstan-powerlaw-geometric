# rstan-powerlaw-geometric

Distinguish power-law and geometric (discrete exponential) distributions using RStan with bridge sampling.

## Synthetic data

* [sim-pl.R](sim-pl.R): generate synthetic data that exhibits power-law with exponent $\alpha = -2$
* [sim-exp.R](sim-exp.R): generate synthetic data that exhibits geometric distribution with $p=.2$

Generated data can be found in the `data/` directory.
Example data and their distributions can be found in the `data-example/` directory.

## Model fitting and comparison

* [discrete-powerlaw.stan](discrete-powerlaw.stan): Stan model for discrete power-law distribution
* [discrete-exponential.stan](discrete-exponential.stan): Stan model for geometric distribution
* [stan-fit-sim-pl.R](stan-fit-sim-pl.R): fit the power-law model with data
* [stan-fit-sim-exp.R](stan-fit-sim-exp.R): fit the geometric model with data
* [model-comparison.R](model-comparison.R): compute the Bayes factor of the two models using bridge sampling, with power-law distributed synthetic data

Results can be found in the `results/` directory.

## Results

Rstan should give the posterior distributions for the power-law exponent $\alpha$ and the success probability $p$ for the geometric distribution.

It should estimate the Bayes factor of the two models as `Inf`, meaning it strongly favors the power-law distribution.

Example results are in the `results-example/` directory.

## Reproducibility

### Environment
To reproduce the results, set up the environment in `renv.lock` with:

```r
renv::restore()
```

### Reproduce results

Then use [stu](https://github.com/kunegis/stu) to build all results:

```sh
stu
```

Clean up the results with:

```sh
stu @clean
```

Alternatively, run the script `run.sh` to build the results:

```
./run.sh
```

## References

* https://fabiandablander.com/r/Law-of-Practice.html (read with caution)
