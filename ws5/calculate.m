function [T] = calculate(method,N,t,dt)
%CALCULATE Summary of this function goes here
%   Detailed explanation goes here
Nx = N;
Ny = N;

%dt = 1./4096;
t_end = t;

T = ones(Nx+2,Ny+2);

T(:,1) = 0;
T(:,end) = 0;
T(1,:) = 0;
T(end,:) = 0;

T = method(T,dt,t_end,Nx,Ny);

end

