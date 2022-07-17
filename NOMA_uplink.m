clc
clear all

% Data
h1_2 = 0.06;
h2_2 = 0.1;
rho_dB = 20;
rho = 10^(0.1 * rho_dB);
t_List = 0:0.01:1;
LEN = length(t_List) + 3;
x = zeros(1, LEN);
y = zeros(1, LEN);
% Vectors without t
% x = [0 R1_max R1_max R1_t0 0];
% y = [0 0 R2_t1 R2_max R2_max];
x(1) = 0;
x(LEN) = 0;
y(1) = 0;
y(2) = 0;


% Calculations
R1_max = log2(1 + rho * h1_2);
R2_max = log2(1 + rho * h2_2);
R1_t1 = log2(1 + h1_2 / (h2_2 + 1/rho));
R2_t0 = log2(1 + h2_2 / (h1_2 + 1/rho));
x(2) = R1_max;
y(LEN) = R2_max;

for i = 1:length(t_List)
    t = t_List(i);
    x(i+2) = t * R1_t1 + (1-t) * R1_max;
    y(i+2) = (1-t) * R2_t0 + t * R2_max;
end

sum_rate_1 = R1_t1 + R2_max;
sum_rate_2 = R2_t0 + R1_max;
if sum_rate_1 == sum_rate_2
    disp("Sum rate in Time-Sharing line: " + num2str(sum_rate_1));
end

% Equation for t
syms t
f1 = t * R1_t1 + (1-t) * R1_max;
f2 = (1-t) * R2_t0 + t * R2_max;
eqn = f1 == f2;
t_eff = vpasolve(eqn, t);
t_eff = sym2poly(t_eff);
f1 = matlabFunction(f1);
R_eq = f1(t_eff);

disp("Same rate for R_1 and R_2 in: t_eff = " + (1-t_eff));
disp("R_1 = " + num2str(R_eq) + ", R_2 = " + num2str(R_eq) + ", R_{max} = " + num2str(2*R_eq));
plot(x, y);
title("Capacity Region");
xlabel("R_1");
ylabel("R_2");