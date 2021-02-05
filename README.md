# phaseI_bridging
OpenBUGS code and R functions to implement the Bayesian hierarchical model for leveraging animal data in phase I oncology trials, involving potentially heterogeneous patient subgroups.

Files contained in this repository can be used to reproduce the numerical results reported in the paper entitled
# H. Zheng., L.V. Hampson., T. Jaki. (2021). Bridging across patient subgroups in phase I oncology trials that incorporate animal data. *Statistical Methods in Medical Research*, Epub ahead of print.

The file "a2hEXNEX.txt" is the model specification for the proposed methodology to be implemented through OpenBUGS, while the file  "a2hEXNEX.R" has R functions calling the OpenBUGS model in R through the R2OpenBUGS package. 

Numerical results reported in Sections 3 and 4 of the paper as well as those in the Supplementary Materials can be reproduced, given the same specification of priors and same set of hypothetical animal data.
