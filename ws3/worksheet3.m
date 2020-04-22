clear all;
clc;
global s_T %stability table to be used in other file

%plot exact solution
t=linspace(0,5,1000);
y=200./(20-10*exp(-7*t));
plot(t,y)
title('Exact solution')
xlabel('t')
ylabel('p')
grid on

%define function and parameter
p=@(x)7*(1-x/10)*x;
p0=20;
dt=[1/2 1/4 1/8 1/16 1/32];
end_t=5;

%initialize stability table
s_T=table(dt','VariableNames',{'dt'});

%Explicit Euler
calculation('Explicit_Euler',@exEuler,p,p0,dt,end_t);
%Heun
calculation('Heun',@Heun,p,p0,dt,end_t);
%Implicit Euler
calculation('Implicit_Euler',@impEuler,p,p0,dt,end_t);
%Adam Moulton
calculation('Adam_Moulton',@adam_moulton,p,p0,dt,end_t);
%Adam Moulton Linear 1
calculation('Adam_Moulton_Linear_1',@adam_moulton_l1,p,p0,dt,end_t);
%Adam Moulton Linear 2
calculation('Adam_Moulton_Linear_2',@adam_moulton_l2,p,p0,dt,end_t);

%show stability table
disp(s_T)
disp("1 for stable;0 for unstable")