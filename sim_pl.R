# Load libraries
# install.packages("dplyr")
library(dplyr)

# Set random seed for reproducibility
set.seed(42)

# Define parameters
N <- 5000          # Number of observations
y_min <- 1.0       # Minimum tau (support for Pareto)

# Compute gamma for each observation
gamma <- 2

# Make sure gamma > 1 for valid sampling
# If needed, shift gamma upwards
#gamma <- abs(gamma) + 1    # Ensure gamma > 1

# function to sample from a discrete power law distribution
rdiscrete_powerlaw <- function(n, y_min, gamma_max) {
  tau <- numeric(n)

  for (i in 1:n) {
    accepted <- FALSE
    while (!accepted) {
      # Propose k
      k <- sample(y_min:(10*y_min), 1)  # Choose maximum as you like
      p_accept <- (k / y_min)^(-gamma_max)  # Unnormalized probability
      if (runif(1) < p_accept) {
        tau[i] <- k
        accepted <- TRUE
      }
    }
  }

  return(tau)
}

# Function to sample from Pareto(y_min, alpha)
rpareto <- function(n, y_min, alpha) {
  u <- runif(n)
  y_min / (u^(1/alpha))
}

# Generate continuous tau
tau_continuous <- rpareto(N, 1, gamma)

tau_integer <- floor(tau_continuous)

# In case any tau < y_min after flooring, set it back to y_min
tau <- pmax(tau_integer, 1)

# Generate tau from power law distribution
#tau <- rdiscrete_powerlaw(N, y_min, gamma)

# Pack into a data frame
synthetic_data <- data.frame(
  tau = tau
)

# save data
write.csv(synthetic_data, "synthetic_data_pl.csv", row.names = FALSE)
