function [Mat,storage]=full_matrix(nx,ny,b)
    hx=1/(nx+1);
    hy=1/(ny+1);
    A=createA(nx,ny);
    Mat_temp=zeros(nx,ny);
    Mat=zeros(nx+2,ny+2);
    b_vec=[];
    for i=1:nx
        for j=1:ny
            b_vec=[b_vec ; b(i*hx,j*hy)];
        end
    end
    Mat_temp(:)=A\b_vec;
    Mat(2:nx+1,2:ny+1)=Mat_temp';
    s=whos('A','Mat_temp','Mat','b_vec');
    storage=0;
    for i=1:length(s)
        storage=storage+s(i).bytes/8;
    end
end