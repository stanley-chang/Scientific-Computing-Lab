% Heun

function [Y_array] = Heun(f_y, y_0, dt, t_end)
%Heun Summary of this function goes here
%   Detailed explanation goes here

Y_array= zeros(1,t_end/dt);
Y_array(1) = y_0;

for t = dt:dt:t_end
    
    y_2 = Y_array(t/dt) + dt.* f_y(Y_array(t/dt));
    
    Y_array(t/dt+1) = Y_array(t/dt) + dt.*(f_y(Y_array(t/dt)) + f_y(y_2))./2.;
end

end

