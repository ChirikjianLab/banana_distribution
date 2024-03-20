clc;
clear;
close all;
addpath("data\");
addpath("functions\");
%% Load data
load("data_s1.mat");
% load("data_c1.mat");
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
% vector x
x = [v1; v2; alpha];

[mu_v, sigma_v] = cal_mc_cert(x(1:2, :), N);

mN = 100;
dx = 0.2;
dy = 0.2;
[v1q, v2q] = meshgrid(linspace(min(v1) - dx, max(v1) + dx, mN), linspace(min(v2) - dy, max(v2) + dy, mN));
% normalizing factor
c = (2*pi)^(2/2)*abs(det(sigma_v))^(1/2);
f_v = zeros(1, numel(v1q));
for j = 1: numel(v1q)
    x3 = [v1q(j); v2q(j)];
    f_v(j) = exp(-(1/2)*((x3 - mu_v)'*sigma_v^(-1)*(x3 - mu_v)))/c;
end
f_v = reshape(f_v, size(v1q));
%% Figure
plot(v1, v2, 'o', MarkerEdgeColor = [102/255 178/255 255/255], MarkerFaceColor = [102/255 178/255 255/255], MarkerSize = 4);
hold on;

max_f_v = max(f_v, [], "all");
min_f_v = min(f_v, [], "all");
mid_f_v = (min_f_v + max_f_v)/2;
dz_v = 1;
v_v = [min_f_v + dz_v, mid_f_v];
contour(v1q, v2q, f_v, v_v, 'r', LineWidth = 2);
axis equal;
xlabel('V1');
ylabel('V2');
if arc == 1
    title('Arc, DT = 1');
else
    title('Straight, DT = 1');
end
