
close all;
t = [1./8,2./8,3./8,4./8];
N = [3,7,15,31];
dt = [1./64, 1./128, 1./256, 1./512, 1./1024, 1./2048, 1./4096];
mkdir figure;

len_t = size(t,2);
len_N = size(N,2);
len_dt = size(dt,2);

%Explicit Euler
for i = 1:len_t
    for j = 1:len_N
        for k=1:len_dt
            
            x=0:1/(N(j)+1):1;
            y=0:1/(N(j)+1):1;

            figure(i);
            fig=subplot(len_N,len_dt,len_dt*(j-1)+k);
            surf(x,y,calculate(@exEuler,N(j),t(i),dt(k)));
            title(strcat('N=',num2str(rats(N(j))),',dt=',num2str(rats(dt(k)))));
            
            %save individual plot
            set(0,'DefaultFigureVisible','off')
            individual_fig=figure;
            new_handle=copyobj(fig,individual_fig);
            set(new_handle, 'Position', get(0, 'DefaultAxesPosition'));
            saveas(gcf,['figure/Explicit_', num2str(t(i)), '_', num2str(N(j)),'_',num2str(dt(k)),'.jpeg']);
            set(0,'DefaultFigureVisible','on')
        end
    end
    sgtitle(figure(i),['Explicit Euler at time t =', num2str(rats(t(i)))])
end

%Implicit Euler
for j = 1:len_t
    for i = 1:len_N
            x=0:1/(N(i)+1):1;
            y=0:1/(N(i)+1):1;
            figure(5);
            fig=subplot(len_t,len_N,len_N*(j-1)+i);
            surf(x,y,calculate(@imEuler,N(i),t(j),dt(1)));
            title(strcat('N=',rats(N(i)),',t=',rats(t(j))));
    end
end
sgtitle(figure(5),['Implicit Euler at time dt =', num2str(rats(1/64))])