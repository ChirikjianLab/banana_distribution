function T = Ad(g)
% g in SE(2)
R = g(1:2, 1:2);
t = g(1:2, end);
M = [0 1; -1 0];
T = [R M*t; 0 0 1];
end

