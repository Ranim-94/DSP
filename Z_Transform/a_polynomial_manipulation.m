

clc, close all;

% Polynomials are used allot in z transform

% Some function to manipulate polynomial 

% In matlab, coefficient of polynomials in decreasing order

% consider the follwing: P(z) = 1 z^0 + 1.5 z^-1 + 2 z^-2

% entering coeff as a row vector
coeff = [1, 1.5 , 2];

% Computing the roots of P(z)

root_pz = roots(coeff);

% Constructing back P(z) from its roots

constructed_coeff = poly(root_pz);

% Evaluating P(z) at some z_value

z_value = 2 ;

pz_value = polyval(coeff,z_value)/z_value^2;

% The reason w divide by z_value^2 because matlab assume polynomials
% with positive exponent --> 

% P(z) = 1 z^0 + 1.5 z^-1 + 2 z^-2
%      = z^-2 (z^2 + 1.5 z + 2)   

