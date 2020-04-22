function [error,error_red]=calculate(method_name,method,nx,ny,b)
    global index; %index for figure
    index=index+2;
    
    error=[];
    error_red=zeros(1,size(nx,2));
    len=size(nx,2);
    for i=1:len
        
        %exact solution
        hx=1/(nx(i)+1);
        hy=1/(ny(i)+1);
        exact_sol=zeros(nx(i),ny(i));
        for m=1:nx(i)
            for n=1:ny(i)
                exact_sol(m,n)=sin(pi*m*hx)*sin(pi*n*hy);
            end
        end
        
        %method solution : record runtime and storage
        tic
        [mat,s]=method(nx(i),ny(i),b);
        t(i)=toc;
        storage(i)=s;
        
        %error
        error=[error sqrt(sum(sum((mat(2:end-1,2:end-1)-exact_sol).^2))/(nx(i)*ny(i)))];
        
        
        x=0:1/(nx(i)+1):1;
        y=0:1/(ny(i)+1):1;
        
        figure(index);
        subplot(2,3,i)
        mesh(x,y,mat);
        title(sprintf('%s, N=%u',method_name,nx(i)))
        zlabel('Temperature')
        
        figure(index+1);
        subplot(2,3,i)
        contour(x,y,mat,'ShowText','on');
        title(sprintf('%s, N=%u',method_name,nx(i)))
        
    end
    disp(method_name)
    rowName={'Nx,Ny','runtime','storage'};
    T=table([nx(2:end);t(2:end);storage(2:end)],'RowNames',rowName);
    disp(T)
    
    %error reduction
    for i=2:len
       error_red(i)=error(i-1)/error(i); 
    end
end