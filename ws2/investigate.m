function [] = investigate(method, methodname, f_y, y_0, dt_array, t_end)
%INVESTIGATE calculates the numerical approximations and errors. Plots the
%results. Displays the results in a table.
%Arguments: method      :   function handle of the method used (eg. Heun)
%           methodname  :   name of the numerical method as a string
%           f_y         :   derivative
%           y_0         :   initial value
%           dt_array    :   array of dt values to be investigated (must be in
%                           decreasing order)
%           t_end       :   stop time

%plot exact solution
figure;
t = 0:.1:t_end;
p = 10./(1 + 9.*exp(-t));
plot(t,p,'LineWidth',1,'DisplayName','exact');
title(methodname);
xlabel('t');
ylabel('y');
hold on;

%Compute the results for all dt values
%Also computes an extra result for dt = dt_array(end)/2 for computing the
%error reduction for the smallest dt
len = length(dt_array);
Results = zeros(len+1,1+2*t_end/min(dt_array)); %row length for extra dt and zero
for i = 1:len
    dt = dt_array(i);
    t = 0:dt:t_end;
    Results(i,1:length(t)) = method(f_y,y_0,dt,t_end); %Calls the method function passed as argument
end
%For the extra dt, for error reduction computation
Results(len+1,:) = method(f_y,y_0,dt_array(end)./2,t_end);


%Plot results
for i = 1:len
    dt = dt_array(i);
    t = 0:dt:t_end;
    plot(t,Results(i,1:length(t)),'-+','DisplayName',strcat('+ dt=',num2str(dt)));
end
hold off;
grid on;
legend('Location','southeast')
legend show;

%Save figure in data/ directory
%warning('off','MATLAB:MKDIR:DirectoryExists');
%mkdir data;
%saveas(gcf,strcat('data/',methodname,'.png'));

%Compute errors
[Error_array, Error_reduction, Error_approx_best] = computeErrors(Results, dt_array, t_end);

%Display in tables
T = table([dt_array; Error_array; Error_reduction; Error_approx_best],'RowNames',{'dt','Error','Error red.','Error app.'});
T.Properties.VariableNames = {methodname};
disp(T);

end

function [Error_array, Error_reduction, Error_approx_best] = computeErrors(Results, dt_array, t_end)
% Compute Errors

len = length(dt_array);

%Compute Approximation Error
Error_array = zeros(1,len);
for i = 1:len
    dt = dt_array(i);
    t = 0:dt:t_end;
    times = length(t);
    sum = 0;
    p = 10./(1 + 9.*exp(-t));
    for j = 1:times
        sum = sum + (Results(i,j) - p(j)).^2;
    end
    Error_array(i) = sqrt(dt.*sum./t_end);
end


% Computing Error Reduction
Error_reduction = zeros(1,len);
for i = 1:len-1
    Error_reduction(i) = Error_array(i)/Error_array(i+1);
end
dt = dt_array(end)/2; %For the smallest dt
t = 0:dt:t_end;
times = length(t);
sum = 0;
p = 10./(1 + 9.*exp(-t));
for j = 1:times
    sum = sum + (Results(end,j) - p(j)).^2;
end
Error = sqrt(dt.*sum./t_end);
Error_reduction(end) = Error_array(end)/Error;


% Computing Error using best approximation
Error_approx_best = zeros(1,len);
for i = 1:len
    dt = dt_array(i);
    t = 0:dt:t_end;
    times = length(t);
    sum = 0;
    for j = 1:times
        sum = sum + (Results(i,j) - Results(end-1,1 + (j-1)*(dt/dt_array(end)))).^2;
    end
    Error_approx_best(i) = sqrt(dt.*sum./t_end);
end

end




