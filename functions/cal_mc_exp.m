function [mu_exp, sigma_exp] = cal_mc_exp(g, N, err)
% Calculate the mean and covariance for exponential coordinates
% g: group, SE(2)
% N: sample number
% err: error
dis = 1;
old_mu = eye(3);
while dis > err
    C = 0;
    for i = 1: N
        C = C + logm(old_mu^(-1)*g{i});
    end
    new_mu = old_mu*expm(C/N);
    dis = norm(new_mu - old_mu);
    old_mu = new_mu;
end
mu_exp = new_mu;
y = zeros(3, N);
E = 0;
for k = 1: N
    y(:, k) = vee(logm(mu_exp^(-1)*g{k}));
    E = E + y(:, k)*y(:, k)';
end
sigma_exp = E/N;
end

