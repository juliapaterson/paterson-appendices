%apply fdr corrections

%hypothesis 1
%mancova
pvalues = [0.016, 0.41, 0.21];
pFDR = mafdr(pvalues,'BHFDR',true);

%t test hemifields
pvalues = [0.23, 0.42, 0.12, 0.22];
pFDR = mafdr(pvalues,'BHFDR',true);

%erps and behaviour (RT)
pvalues = [0.22,0.80,0.89,0.75,0.001,0.002,0.001,0.04,0.02,0.003,0.004,0.02,0.009,0.001,0.03,0.004,0.001];
pFDR = mafdr(pvalues,'BHFDR',true);

%hemifield anova
pvalues = [0.957,0.603,0.031,0.05,0.028,0.034,0.270,0.804,0.02,0.842];
pFDR = mafdr(pvalues,'BHFDR',true);

%hypothesis 2
%n2c amp t test
pvalues = [0.04,0.59,0.93,0.16];
pFDR = mafdr(pvalues,'BHFDR',true);

%n2 latency
pvalues = [0.001,0.89,0.27,0.16];
pFDR = mafdr(pvalues,'BHFDR',true);

%hypothesis 3

%cpp slope & amp already non-sig

%cpp latency also non-sig

%supplementary fcn
pvalues = [0.02, 0.02];
pFDR = mafdr(pvalues,'BHFDR',true);