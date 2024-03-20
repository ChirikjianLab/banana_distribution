% stochastic differential equations
% dPhi_i = w_i(t)*dt + sqrt(D)*dw_i
clc;
clear;
addpath("functions\");
l = 0.2; % wheel base, m
r = 0.033; % radius of each wheel, m
T = 1; % total time, s
a = 1; % radius, m
alpha_dot = 2*pi*a/4; % counter-clockwise rate
x_init = [0 0 0]'; % inital x y theta condition
dt = 0.001; % time step, s
points = T/dt; % grid points
v = 1; % velocity, m/s
N = 10000; % runs
ts = linspace(0, T, points);
xs = zeros(3, points);
xs(:, 1) = x_init;
% random variable with mean 0 and stdev of sqrt(dt)
pd = makedist('Normal', 0, sqrt(dt));
%% Straight, DT = 1
D = 1; % noise coefficient
w1 = v/r;
w2 = v/r;
data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2);
save('data\data_s1.mat', 'data');
%% Straight, DT = 2
D = 2; % noise coefficient
w1 = v/r;
w2 = v/r;
data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2);
save('data\data_s2.mat', 'data');
%% Straight, DT = 3
D = 3; % noise coefficient
w1 = v/r;
w2 = v/r;
data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2);
save('data\data_s3.mat', 'data');
%% Straight, DT = 4
D = 4; % noise coefficient
w1 = v/r;
w2 = v/r;
data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2);
save('data\data_s4.mat', 'data');
%% Straight, DT = 5
D = 5; % noise coefficient
w1 = v/r;
w2 = v/r;
data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2);
save('data\data_s5.mat', 'data');
%% Straight, DT = 6
D = 6; % noise coefficient
w1 = v/r;
w2 = v/r;
data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2);
save('data\data_s6.mat', 'data');
%% Straight, DT = 7
D = 7; % noise coefficient
w1 = v/r;
w2 = v/r;
data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2);
save('data\data_s7.mat', 'data');
%% Curvature, DT = 1
D = 1; % noise coefficient
w1 = (alpha_dot/r)*(a + l/2);
w2 = (alpha_dot/r)*(a - l/2);
data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2);
save('data\data_c1.mat', 'data');
%% Curvature, DT = 2
D = 2; % noise coefficient
w1 = (alpha_dot/r)*(a + l/2);
w2 = (alpha_dot/r)*(a - l/2);
data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2);
save('data\data_c2.mat', 'data');
%% Curvature, DT = 3
D = 3; % noise coefficient
w1 = (alpha_dot/r)*(a + l/2);
w2 = (alpha_dot/r)*(a - l/2);
data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2);
save('data\data_c3.mat', 'data');
%% Curvature, DT = 4
D = 4; % noise coefficient
w1 = (alpha_dot/r)*(a + l/2);
w2 = (alpha_dot/r)*(a - l/2);
data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2);
save('data\data_c4.mat', 'data');
