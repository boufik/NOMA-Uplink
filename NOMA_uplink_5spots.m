clc
clear all

% Data
h1_2 = 0.06;
h2_2 = 0.1;
rho_dB = 20;
rho = 10^(0.1 * rho_dB);

% Spots of the capacity region
R1_max = log2(1 + rho * h1_2);
R2_max = log2(1 + rho * h2_2);
R1_t0 = log2(1 + h1_2 / (h2_2 + 1/rho));
R2_t1 = log2(1 + h2_2 / (h1_2 + 1/rho));
x = [0 R1_max R1_max R1_t0 0];
y = [0 0 R2_t1 R2_max R2_max];

plot(x, y);
title("Capacity Region");
xlabel("R_1");
ylabel("R_2");