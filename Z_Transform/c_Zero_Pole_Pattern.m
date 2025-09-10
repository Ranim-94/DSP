



clc, close all;

coeff_num = [1 0 -1];

coeff_deno = [1 0.9 0.6 0.05];

% drawing the zero-pole diagram in the z-plane

zplane(coeff_num,coeff_deno)

% Plotting h[n] numerically using impz

number_samples = 100;

impz(coeff_num,coeff_deno,number_samples)

