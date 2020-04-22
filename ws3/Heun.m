%Heun
function result=Heun(f,y0,dt,end_t)
    result=y0;
    for j=1:end_t/dt
        y_next0=result(j)+dt*f(result(j));
        y_next=result(j)+dt*(f(result(j))+f(y_next0))/2;
        result=[result y_next];
    end
end