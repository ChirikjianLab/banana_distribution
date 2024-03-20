clc;
clear;
addpath("data\");
addpath("functions\");
%% Calculate Arc LL ratio
y_c = zeros(1, 4);
x_c = zeros(1, 4);
for n = 1: 4
    switch n
        case 1
            load("data_c1.mat");
        case 2
            load("data_c2.mat");
        case 3
            load("data_c3.mat");
        case 4
            load("data_c4.mat");
        otherwise
            disp('otherwise');
    end
    y_c(n) = gaussian_LL(data);
    x_c(n) = n;
end
%% Calculate Straight LL ratio
y_s = zeros(1, 6);
x_s = zeros(1, 6);
for n = 1: 6
    switch n
        case 1
            load("data_s1.mat");
        case 2
            load("data_s2.mat");
        case 3
            load("data_s3.mat");
        case 4
            load("data_s4.mat");
        case 5
            load("data_s5.mat");
        case 6
            load("data_s6.mat");
        otherwise
            disp('otherwise');
    end
    y_s(n) = gaussian_LL(data);
    x_s(n) = n;
end
%% Save data
% curvature
data_arc.x = x_c;
data_arc.y = y_c;
save('data\data_arc.mat', 'data_arc');
% straight
data_str.x = x_s;
data_str.y = y_s;
save('data\data_str.mat', 'data_str');
