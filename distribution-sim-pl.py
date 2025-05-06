#!/usr/bin/env python3
# coding: utf-8
import pandas as pd
import numpy as np
import powerlaw

import matplotlib.pyplot as plt

# In[2]:


df = pd.read_csv('synthetic_data_pl.csv')

tau = df['tau'].values

bins = np.unique(tau)
hist, _ = np.histogram(tau, np.append(bins, max(bins)+1))

# plot degree distribution
fig, ax = plt.subplots()

plt.autoscale(enable=True, tight=True)
plt.loglog(bins, hist, '.', label='synthetic')
plt.xlabel(r'# Timesteps t')
plt.ylabel('Frequency')

plt.savefig('synthetic_data_pl.pdf', dpi=300, bbox_inches='tight')

ccdf = np.cumsum(hist[::-1])[::-1]
ccdf = ccdf / ccdf[0]

plt.clf()

plt.loglog(bins, ccdf)
plt.xlabel(r'# Timesteps t')
plt.ylabel(r'P($\tau$ >= t)')
plt.savefig('synthetic_data_pl_ccdf.pdf', dpi=300, bbox_inches='tight')


# fit power law
fit = powerlaw.Fit(tau, discrete=True, xmin=1)
alpha = fit.power_law.alpha
xmin = fit.power_law.xmin
print(f"alpha: {alpha}")
print(f"xmin: {xmin}")
