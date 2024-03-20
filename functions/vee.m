function vector = vee(lie_algebra)
% vee(v) operation
v1 = lie_algebra(1, 3);
v2 = lie_algebra(2, 3);
v3 = lie_algebra(2, 1);
vector = [v1; v2; v3];
end

