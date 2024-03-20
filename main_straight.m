clc;
clear;
close all;
addpath("data\");
addpath("functions\");
%% Load data
load("data_s1.mat");
% load("data_s7.mat");
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
% calculate the mean and covariance
[mu_c, sigma_c] = cal_mc_cert(data, N);
[mu_exp, sigma_exp] = cal_mc_exp(g, N, err1);
% normalizing factor
c = (2*pi)^(3/2)*abs(det(sigma_c))^(1/2);
pdf_exp = zeros(1, N);
% Samples data in multidimensional Gaussian pdf
for m = 1: numel(g)
    g_exp = g{m};
    y_exp = vee(logm(mu_exp^(-1)*g_exp));
    pdf_exp(m) = exp(-(1/2)*(y_exp'*sigma_exp^(-1)*y_exp))/c;
end
pdf_c = zeros(1, N);
for m = 1: size(x, 2)
    x1 = [t1(m); t2(m); alpha(m)];
    pdf_c(m) = exp(-(1/2)*((x1 - mu_c)'*sigma_c^(-1)*(x1 - mu_c)))/c;
end
%% Meshgrid
mN = 100;
dx = 0.3;
dy = 0.3;
[xq, yq] = meshgrid(linspace(min(t1) - dx, max(t1) + dx, mN), linspace(min(t2) - dy, max(t2) + dy, mN));
thetaq = atan2(yq, xq) + 0;
%% Certesian
f_c = zeros(1, numel(xq));
for j = 1: numel(xq)
    x2 = [xq(j); yq(j); thetaq(j)];
    f_c(j) = exp(-(1/2)*((x2 - mu_c)'*sigma_c^(-1)*(x2 - mu_c)))/c;
end
f_c = reshape(f_c, size(xq));
%% Exponential
mesh_g = cell(1, numel(xq));
f_exp = zeros(1, numel(xq));
for t = 1: numel(xq)
    mesh_g{t} = [cos(thetaq(t)) -sin(thetaq(t)) xq(t);
             sin(thetaq(t)) cos(thetaq(t)) yq(t);
             0 0 1];
    g_exp = mesh_g{t};
    y_exp = vee(logm(mu_exp^(-1)*g_exp));
    f_exp(t) = exp(-(1/2)*(y_exp'*sigma_exp^(-1)*y_exp))/c;
end
f_exp = reshape(f_exp, size(xq));
%% Figure
plot(t1, t2, 'o', MarkerEdgeColor = [102/255 178/255 255/255], MarkerFaceColor = [102/255 178/255 255/255], MarkerSize = 4);
hold on;
plot([0, 1], [0, 0], 'k--', LineWidth = 2.5);
max_f_c = max(f_c, [], "all");
min_f_c = min(f_c, [], "all");
mid_f_c = (min_f_c + max_f_c)/2;
dz_c = 0.1;
level = [min_f_c + dz_c, (min_f_c + mid_f_c)/3, mid_f_c];

contour(xq, yq, f_c, level, 'r', LineWidth = 2);
contour(xq, yq, f_exp, level, 'b', LineWidth = 2);

legend('Samples', 'Ideal trajectory', 'XY pdf', 'Exp pdf', Location='northwest');
xlim([-0.5 1.5]);
ylim([-1 1]);
xlabel('X Position');
ylabel('Y Position');

