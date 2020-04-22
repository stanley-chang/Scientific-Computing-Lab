function A=createA(nx,ny)
    hx=1/(nx+1);
    hy=1/(ny+1);
    A=zeros(nx*ny,nx*ny);
    for i=1:nx*ny
       for j=1:nx*ny
           if i==j
                A(i,j)=-2*(1/hx^2+1/hy^2);
           elseif abs(i-j)==1 && mod(i,nx)+mod(j,nx)~=1
               A(i,j)=1/hx^2;
           elseif i-nx==j || j-nx==i
               A(i,j)=1/hy^2;
           end
       end
    end
end