% Explicit Euler

function [T] = exEuler(T, dt, t_end,Nx,Ny)
%EXEULER Summary of this function goes here
%   Detailed explanation goes here

hx = 1./(Nx+1);
hy = 1./(Ny+1);
Tnext = T;
for t = dt:dt:t_end
    for i = 2:Nx+1
        for j = 2:Ny+1
            Txx = (T(i-1,j) - 2.*T(i,j) + T(i+1,j))./hx.^2;
            Tyy = (T(i,j-1) - 2.*T(i,j) + T(i,j+1))./hy.^2;
            Tdt = Txx + Tyy;
            Tnext(i,j) = T(i,j) + dt.*Tdt;
        end
    end
    T = Tnext;
end

end

