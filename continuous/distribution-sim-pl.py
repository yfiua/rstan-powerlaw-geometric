#!/usr/bin/env python3
# coding: utf-8
import pandas as pd
import numpy as np

import matplotlib.pyplot as plt



df = pd.read_csv('simulated_data_continuous.csv')

# PDF
p = df['x'].values - 1.3
bins = np.arange(1, len(p) + 1)

# plot PDF
fig, ax = plt.subplots()

plt.loglog(bins[:800], p[:800], '.')
plt.savefig('synthetic_data_pl.png', dpi=300, bbox_inches='tight')

# plot CCDF distribution
plt.clf()

ccdf = np.cumsum(p[::-1])[::-1]
ccdf = ccdf / ccdf[0]


plt.loglog(bins[:800], ccdf[:800])
plt.xlabel(r'# Timesteps t')
plt.ylabel(r'P($\tau$ >= t)')
plt.savefig('synthetic_data_pl_ccdf.pdf', dpi=300, bbox_inches='tight')
plt.savefig('synthetic_data_pl_ccdf.png', dpi=300, bbox_inches='tight')

