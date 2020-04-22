clear all;
clc;

%define parameter and function
nx=[3 7 15 31 63];
ny=[3 7 15 31 63];

b=@(x,y)(-2*pi^2*sin(pi*x)*sin(pi*y));

%plot index for different figure
global index;
index=-1;

%Full matrix
calculate('Full Matrix',@full_matrix,nx,ny,b);

%Sparse matrix
calculate('Sparse Matrix',@sparse_matrix,nx,ny,b);

%Guass Seidel
[error,error_red]=calculate('Gauss Seidel',@gauss_seidel,nx,ny,b);

%table for error of gauss seidel
disp('Error of Gauss Seidel')
rowNames={'Nx,Ny','error','error_red'};
T=table([nx(2:end);error(2:end);error_red(2:end)],'RowNames',rowNames);
disp(T);
