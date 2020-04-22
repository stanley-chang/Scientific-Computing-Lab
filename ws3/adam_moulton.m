function y=adam_moulton(f,y0,dt,end_t)
    y=y0;
    for i=1:end_t/dt
        g=@(x)(x-dt/2*(f(x)+f(y(i)))-y(i));
        d_g=@(x)(1-7/2*dt+7/10*dt*x); %manually derived
        y_n=y0; %initial guess
        error=abs(g(y_n));
        counter=0;
        while error>10e-4 && abs(d_g(y_n))>=1e-5 && counter<= 1000
            y_next=y_n-g(y_n)/d_g(y_n);
            y_n=y_next;
            error=abs(g(y_n));
            counter=counter+1;
        end
        y=[y y_next];
    end
end