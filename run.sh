#!/bin/sh
# This script is used to reproduce the project results.

# It is assumed that the user has already installed the required dependencies in renv.lock.

## make directories
mkdir -p data
mkdir -p results

## synthetic data generation
Rscript sim-pl.R
Rscript sim-exp.R

## model fitting
Rscript stan-fit-sim-pl.R
Rscript stan-fit-sim-exp.R

## model comparison
Rscript model-comparison-pl.R > results/model-comparison-pl
Rscript model-comparison-exp.R > results/model-comparison-exp
