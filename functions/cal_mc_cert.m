function [mu_c, sigma_c] = cal_mc_cert(data, N)
% Calculate the mean and covariance for Cartesian coordinates
% data: 3xN sample points
% N: sample number
mu_c = sum(data, 2)./N; % mean
sigma_c = 0;
for k = 1: N
    sigma_c = sigma_c + (data(:, k) - mu_c)*(data(:, k) - mu_c)';
end
sigma_c = sigma_c/N; % standard deviation
end

