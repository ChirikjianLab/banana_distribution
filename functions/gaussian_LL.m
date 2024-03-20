function y = gaussian_LL(data)
% Calculate the LL exp/ LL cart
% Input: points data
% Output: LL exp/ LL cart
    t1 = data(1, :);
    t2 = data(2, :);
    alpha = data(3, :);
    N = numel(t1);
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
    % calculate the mean and covariance for Cartesian coordinates
    [mu_c, sigma_c] = cal_mc_cert(data, N);
    % calculate the mean and covariance for exponential coordinates
    [mu_exp, sigma_exp] = cal_mc_exp(g, N, err1);
    %% Log-likelihood function
    T = 0;
    for m = 1: N
        x1 = [t1(m); t2(m); alpha(m)];
        T = T + (x1 - mu_c)'*sigma_c^(-1)*(x1 - mu_c);
    end
    % log-likelihood in Cartesian coordinates
    LL_c = -(N/2)*log(det(sigma_c)) - (1/2)*T - (3*N/2)*log(2*pi);
    X = 0;
    for m = 1: N
        y_exp = vee(logm(mu_exp^(-1)*g{m}));
        X = X + y_exp'*sigma_exp^(-1)*y_exp;
    end
    % log-likelihood in exponential coordinates
    LL_exp = -(N/2)*log(det(sigma_exp)) - (1/2)*X - (3*N/2)*log(2*pi);
    y = LL_exp/LL_c;
end

