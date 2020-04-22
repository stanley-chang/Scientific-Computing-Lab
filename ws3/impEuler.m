function y=impEuler(f,y0,dt,end_t)
    y=y0;
    for i=1:end_t/dt
        g=@(x)(x-dt*f(x)-y(i));
        d_g=@(x)(7/5*dt*x+1-7*dt); %manually derived
        y_n=y0; %initial guess
        error=abs(g(y_n));
        counter=0;
        while error>10e-4 && abs(d_g(y_n)) >=1e-5 && counter<=1000
            y_next=y_n-g(y_n)/d_g(y_n);
            y_n=y_next;
            error=abs(g(y_n));
            counter=counter+1;
        end
        y=[y y_n];
    end
end