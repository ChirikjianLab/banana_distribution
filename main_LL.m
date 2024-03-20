clc;
clear;
close all;
addpath("data\");
addpath("functions\");
%% Load data
load('data_arc.mat');
load('data_str.mat');
x_c = data_arc.x;
y_c = data_arc.y;
x_s = data_str.x;
y_s = data_str.y;
%% Figure
plot(x_c, y_c, '--*', LineWidth = 1); hold on;
plot(x_s, y_s, '-o', LineWidth = 1);
legend('Arc', 'Straight', Location='northwest');
xlim([0 6]);
ylim([0.9 1.7]);
xlabel('DT');
ylabel('LL exp / LL Cart');
