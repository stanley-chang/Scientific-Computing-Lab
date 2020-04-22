% Implicit Euler

function [T]=imEuler(T, dt, t_end,Nx,Ny)
    hx = 1./(Nx+1);
    hy = 1./(Ny+1);
    N=Nx*Ny;
    Tnext = T;
    for t = dt:dt:t_end
        residual = 1;
        while (residual>1e-6)
            for i=2:Nx+1
                for j=2:Ny+1
                    Tnext(i,j) = (T(i,j)+dt/hx^2*Tnext(i-1,j)+dt/hx^2*Tnext(i+1,j)+dt/hy^2*Tnext(i,j-1)+dt/hy^2*Tnext(i,j+1))/(1+2*dt/hx^2+2*dt/hy^2);
                end
            end
            residual_sum=0;
            for i=2:Nx+1
                for j=2:Ny+1
                    residual_sum=residual_sum+(Tnext(i,j)*(1+2*dt/hx^2+2*dt/hy^2)-(T(i,j)+dt/hx^2*Tnext(i-1,j)+dt/hx^2*Tnext(i+1,j)+dt/hy^2*Tnext(i,j-1)+dt/hy^2*Tnext(i,j+1)))^2;
                end
            end
            residual=sqrt(residual_sum/N);
        end
        T = Tnext;
    end
end