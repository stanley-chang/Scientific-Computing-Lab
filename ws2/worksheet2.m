%Worksheet2 Group 5
%Sooraj, Stanley, Brian
clc;
close all;

% a) plot the exact solution
figure;
t = 0:0.1:10;
p = 10./(1 + 9.*exp(-t));
plot(t,p,'LineWidth',1,'DisplayName','exact');
title('Exact Solution');
xlabel('t');
ylabel('y');
grid on;
legend('Location','southeast')
legend show;


%b ) Numerical calculations
y_0         =   1;
dt_array    =   [1., 1./2., 1./4., 1./8.]; % Always give in decreasing order
t_end       =   5;

%syms f_y(p);
f_y = @(p) (1- p./10).*p;
%f_y(p) = ( 1- p./10).*p;

investigate(@exEuler,'Explicit Euler', f_y, y_0, dt_array, t_end);
investigate(@Heun, 'Heun', f_y, y_0, dt_array, t_end);
investigate(@RungeKutta, 'Runge-Kutta', f_y, y_0, dt_array, t_end);
