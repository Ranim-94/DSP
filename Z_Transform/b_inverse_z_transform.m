



%% Partial Fraction expansion <--> residuez

% X(z) = 6 - 10 z^-1 + 2 z^-2 / 1 - 3 z^-1 + 2 z^-2

%      = 1 +  2/ 1 - z^-1  + 3/1 - 2 z^-1 (1rst order distinct terms)

clc, close all;

coeff_num = [6 -10 2];

coeff_deno = [1 -3 2];

% getting the first order distinc terms

[terms,poles,num_constants] = residuez(coeff_num,coeff_deno);


% we can also construct the rational fraction using the same function  residuez


[coeff_num_2 ,coeff_deno_2 ] = residuez(terms,poles,num_constants);


