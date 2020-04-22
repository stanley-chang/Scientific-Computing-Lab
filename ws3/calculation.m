function calculation(method_name,method,f,y0,dt,end_t)
global s_T
    %plot numerical solution and exact one
    t=linspace(0,5,1000);
    exact_y=200./(20-10*exp(-7*t));
    len=size(dt,2);
    figure;
    for i=1:len
        result{i}=method(f,y0,dt(i),end_t);
        txt=strcat('dt=',num2str(rats(dt(i))));
        plot(0:dt(i):end_t,result{i},'-*','displayname',txt);
        hold on
    end
    plot(t,exact_y,'displayname','Exact sol.');
    axis([0 5 0 20])
    title(method_name,'Interpreter','none')
    xlabel('t')
    ylabel('y')
    legend show
    grid on
    hold off
    
    %Error
    error=zeros(1,len);
    for i=1:len
        exact_y=200./(20-10*exp(-7*(0:dt(i):end_t)));
        y=sqrt(dt(i)/end_t*sum((result{i}-exact_y).^2));
        error(i)=y;
    end
    
    %Error reduction
    error_red=zeros(1,len);
    for i=1:len-1
        error_red(i+1)=error(i)/error(i+1);
    end
    
    %Table
    rowName={'dt';'error';'error_red'};
    T=table([dt;error;error_red],'RowNames',rowName,'VariableNames',{method_name});
    disp(T)
    
    %Check Stability
    %--use the flag vector to record the situation when the difference between
    %--3 adjacent points are decreasing
 
    %--if 3/4 of the instances when the above-mentioned holds
    %--then record "stable", otherwise "unstable"
    %--update the table (add new column)
    flag=[];
    for i=1:len
       stable_flag=1;
       for j=2:size(result{i},2)-1
           diff1=abs(result{i}(j)-result{i}(j-1));
           diff2=abs(result{i}(j+1)-result{i}(j));
          if diff1<diff2 
              stable_flag=0;
          end
       end
       if stable_flag==1
             flag=[flag;1]; %push 'stable' to flag
       else
             flag=[flag;0]; %push 'unstable' to flag
       end
    end
    s_T=[s_T table(flag,'VariableNames',{method_name})];
end