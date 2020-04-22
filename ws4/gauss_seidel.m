function [S,storage]=gauss_seidel(nx,ny,b)
    hx=1/(nx+1);
    hy=1/(ny+1);
    S=zeros(nx+2,ny+2); %additional rows and cols for boundary condition
    N=nx*ny;
    flag=true;
    while (flag)
        for i=2:nx+1
            for j=2:ny+1
                S(i,j)=(b((i-1)*hx,(j-1)*hy)-(S(i-1,j)+S(i+1,j))/hx^2-(S(i,j-1)+S(i,j+1))/hy^2)/(-2/hx^2-2/hy^2);
            end
        end
        residual_sum=0;
        for i=2:nx+1
            for j=2:ny+1
                residual_sum=residual_sum+((b((i-1)*hx,(j-1)*hy)-(S(i-1,j)+S(i+1,j))/hx^2-(S(i,j-1)+S(i,j+1))/hy^2)-S(i,j)*(-2/hx^2-2/hy^2))^2;
            end
        end
        residual=sqrt(residual_sum/N);
        if residual<=1e-4
            flag=false;
        end
    end
    s=whos('S');
    storage=s.bytes/8;
end