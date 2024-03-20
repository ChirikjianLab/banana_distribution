% VI. PROPAGATION WITH EXPONENTIAL COORDINATES
clc;
clear;
close all;
addpath("data\");
addpath("functions\");
syms a a_d t r l D w real
H = [r/2, r/2; 0, 0; r/l, -r/l]; % diffusion matrix
%% load data, DT = 1, straight
load("data_s1.mat");
t1 = data(1, :);
t2 = data(2, :);
alpha = data(3, :);
N = 10000;
err1 = 1e-4;
g = cell(1, N);
X = cell(1, N);
v1 = zeros(1, N);
v2 = zeros(1, N);
for j = 1: N
    % calculate g, lie group, SE(2)
    g{j} = [cos(alpha(j)) -sin(alpha(j)) t1(j);
         sin(alpha(j)) cos(alpha(j)) t2(j);
         0 0 1];
    % calculate X, lie algebra, se(2)
    X{j} = logm(g{j});
    v1(j) = X{j}(1, 3);
    v2(j) = X{j}(2, 3);
end
[mu_exp1, sigma_exp1] = cal_mc_exp(g, N, err1);
%% load data, DT = 7, straight
load("data_s7.mat");
t1 = data(1, :);
t2 = data(2, :);
alpha = data(3, :);
N = 10000;
err1 = 1e-4;
g = cell(1, N);
X = cell(1, N);
v1 = zeros(1, N);
v2 = zeros(1, N);
for j = 1: N
    % calculate g, lie group, SE(2)
    g{j} = [cos(alpha(j)) -sin(alpha(j)) t1(j);
         sin(alpha(j)) cos(alpha(j)) t2(j);
         0 0 1];
    % calculate X, lie algebra, se(2)
    X{j} = logm(g{j});
    v1(j) = X{j}(1, 3);
    v2(j) = X{j}(2, 3);
end
[mu_exp7, sigma_exp7] = cal_mc_exp(g, N, err1);
%% w1 = w2
mu_c1 = [1 0 r*w*t; 0 1 0; 0 0 1]; % formula 32
T = H*H'*D;
E1 = Ad(mu_c1^(-1));
F1 = simplify(E1*T*E1');
sigma1 = int(F1, t, 0, 't');
disp(sigma1); % formula 33
%% w1 != w2
mu_c2 = [cos(a_d*t) -sin(a_d*t) a*sin(a_d*t); sin(a_d*t) cos(a_d*t) a*(1 - cos(a_d*t)); 0 0 1]; % formula 34
E2 = Ad(mu_c2^(-1));
F2 = simplify(E2*T*E2');
sigma2 = int(F2, t, 0, 't');
disp(sigma2); % formula 35
%% Propagation, DT = 1
% rw = 1, DT = 1, r = 0.033, l = 0.2
disp('-----------------DT = 1-----------------')
disp('mu_data:'); disp(mu_exp1);
mu_prop_s = double(subs(mu_c1, [r t w], [0.033 1 1/0.033])); disp('mu_prop:'); disp(mu_prop_s);
disp('sigma_data:'); disp(sigma_exp1);
sigma_prop_s = double(subs(sigma1, [D r t w l], [1 0.033 1 1/0.033 0.2])); disp('sigma_prop:'); disp(sigma_prop_s);
%% Propagation, DT = 7
% rw = 1, DT = 7, r = 0.033, l = 0.2
disp('-----------------DT = 7-----------------')
disp('mu_data:'); disp(mu_exp7);
mu_prop_s = double(subs(mu_c1, [r t w], [0.033 1 1/0.033])); disp('mu_prop:'); disp(mu_prop_s);
disp('sigma_data:'); disp(sigma_exp7);
sigma_prop_s = double(subs(sigma1, [D r t w l], [7 0.033 1 1/0.033 0.2])); disp('sigma_prop:'); disp(sigma_prop_s);
