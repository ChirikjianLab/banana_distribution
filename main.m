close all
clear
clc

%%
for mode = [2]        % driving along straight line mode = 1, driving along an arc path mode = 2
    for D = [4]      % in paper, D = 1,4,7.
        Banana(mode,D);
    end
end