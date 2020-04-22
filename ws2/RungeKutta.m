% Runge-Kutta

function [Y_array] = RungeKutta(f_y, y_0, dt, t_end)
%RungeKutta 

Y_array= zeros(1,t_end/dt);
Y_array(1) = y_0;

for t = dt:dt:t_end
    
    y_1 = f_y(Y_array(t/dt));
    y_2 = f_y(Y_array(t/dt) + y_1.*dt./2);
    y_3 = f_y(Y_array(t/dt) + y_2.*dt./2);
    y_4 = f_y(Y_array(t/dt) + y_3.*dt);
    
    Y_array(t/dt+1) = Y_array(t/dt) + dt.*(y_1 + 2.*y_2 + 2.*y_3 + y_4)./6.;
end

end