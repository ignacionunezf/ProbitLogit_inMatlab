function f=logll(theta);

global y;
global X;

fprintf('Parameters:  %8.4f %8.4f %8.4f \n',theta(1),theta(2),theta(3))

u=X*theta;
N=size(u,1);
sum=0;
for i=1:N
sum=sum+(1/N)*log(((exp(u(i))/(1+exp(u(i))))^y(i))*((1/(1+exp(u(i))))^(1-y(i))));
end
f=-sum;
fprintf('Objective Function Value:  %20.16f \n',f)
