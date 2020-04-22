%explicit Euler
function result=exEuler(f,y0,dt,end_t)
    result=y0;
    for j=1:end_t/dt
        y_next=result(j)+dt*f(result(j));
        result=[result y_next];
    end
end