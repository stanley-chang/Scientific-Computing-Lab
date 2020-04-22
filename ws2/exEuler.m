% Explicit Euler

function [Y_array] = exEuler(f_y, y_0, dt, t_end)
%EXEULER Summary of this function goes here
%   Detailed explanation goes here

Y_array= zeros(1,t_end/dt);
Y_array(1) = y_0;

for t = dt:dt:t_end
    
    Y_array(t/dt+1) = Y_array(t/dt) + dt.* f_y(Y_array(t/dt));
end

end

