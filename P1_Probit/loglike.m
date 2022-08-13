function f=loglike(theta)

global y;
global X;
u=X*theta;
N=size(u,1);
f=zeros(N,1);
for i=1:N
f(i)=log((normcdf(u(i))^y(i))*((1-normcdf(u(i)))^(1-y(i))));
end


