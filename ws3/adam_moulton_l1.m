function y=adam_moulton_l1(f,y0,dt,end_t)
    y=y0;
    for i=1:end_t/dt
        g=@(x)(x-dt/2*(f(x)/x*y(i)+f(y(i)))-y(i));
        d_g=1+7/20*dt*y(i); %manually derived
        y_n=5; %initial guess
        error=abs(g(y_n));
        counter=0;
        while error>=1e-4 && abs(d_g) >=1e-5 && counter<=1000
            y_next=y_n-g(y_n)/d_g;
            y_n=y_next;
            error=abs(g(y_n));
            counter=counter+1;
        end
        y=[y y_n];
    end
end