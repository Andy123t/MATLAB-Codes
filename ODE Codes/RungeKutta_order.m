% RungeKutta_order.m
% Runge-Kutta method for the ODE model
% u'(t)=t^2+t-u, t \in [0,2] 
% Initial value : u(0)=0 ;
% Exact solution : u(t)=-exp(-t)+t^2-t+1.
clear all
Nvec=[10 50 100 500 1000];        % Number of splits
Error=[];
fun=@(t,u) t.^2+t-u;              % RHS
for k=1:length(Nvec)
    N=Nvec(k);
    h=1/N;
    x=0:h:1;                      % function interval
    u(1)=0;                       % initial value
    for i=1:N
        k1=fun(x(i),u(i));
        k2=fun(x(i)+h./2,u(i)+h.*k1/2);
        k3=fun(x(i)+h./2,u(i)+h.*k2/2);
        k4=fun(x(i)+h,u(i)+h.*k3);
        u(i+1)=u(i)+h.*(k1+2.*k2+2.*k3+k4)./6;
    end
    ue=-exp(-x)+x.^2-x+1;         % exact solution
    error=max(abs(u-ue));
    Error=[Error,error];
end
plot(log10(Nvec),log10(Error),'ro-','MarkerFaceColor','w','LineWidth',1.5)
hold on,
plot(log10(Nvec), log10(Nvec.^(-4)), '--')
grid on,
xlabel('log_{10}N','fontsize', 16), ylabel('log_{10}Error','fontsize',16)
title('Convergence of Runge-Kutta Method','fontsize',14)
set(gca,'fontsize',14)
for i=1:length(Nvec)-1     % computating convergence order
    order(i)=-log(Error(i)/Error(i+1))/(log(Nvec(i)/Nvec(i+1)));
end
Error
order