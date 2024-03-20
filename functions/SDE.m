function data = SDE(N, dt, ts, xs, r, l, D, pd, w1, w2)
% stochastic differential equations
% dPhi_i = w_i(t)*dt + sqrt(D)*dw_i
% N: runs
% dt: time step, s
% ts: linearly time, s
% xs: linearly x = [x, y, theta]'
% r: radius of each wheel, m
% l: wheel base, m
% D: noise coefficient
% pd: random variable with mean 0 and stdev of sqrt(dt)
% w1: right wheel speed
% w2: left wheel speed
data = zeros(3, N);
for j = 1 : N
    for i = 2 : numel(ts)
        t = 0 + (i - 1) .* dt;
        x = xs(:, i - 1);
        F = [(r/2)*(w1 + w2)*cos(x(3));
            (r/2)*(w1 + w2)*sin(x(3));
            (r/l)*(w1 - w2)];
        G = sqrt(D)*[(r/2)*cos(x(3)), (r/2)*cos(x(3));
                    (r/2)*sin(x(3)), (r/2)*sin(x(3));
                    r/l, -r/l];
        dW1 = random(pd);
        dW2 = random(pd);
        dW = [dW1; dW2];
        xs(:, i) = x + F * dt + G * dW;
    end
    data(:, j) = xs(:, end);
end
end

