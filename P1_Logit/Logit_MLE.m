% Estimation of binary logit model with 3 regressors using MLE
% Ignacio Nunez, Economics Department, UT-Austin, ijnunez@utexas.edu

clear;clear global;

% First, I load the data into variables

load ps2.dat;  
data=ps2;

global y;
global x;
global z;
global X;

y=data(:,1);
x=data(:,2:3);
z=data(:,4);
X1=ones(size(x,1),1);
X=[X1,x];

% Second, I choose a vector of initial values. 
% The optimal values are stored in theta_hat.

options = optimset('Display','final','TolFun',1e-8,'MaxIter',100000);
theta=[0; 0; 0]; % Starting Values
test = logll(theta);
theta_hat = fminsearch('logll',theta,options);

% Third, I calculate the sum of the derivates of the individual
% loglikelihood functions. For this I defined a new function loglike that
% gives the individual loglikelihood at theta_hat. The derivates are stored
% in DL_theta1, DL_theta2, and DL_theta3. 

L=loglike(theta_hat);
step=0.000001;
DL_theta1=(loglike([theta_hat(1)*(1+step);theta_hat(2);theta_hat(3)])-loglike(theta_hat))/(step*theta_hat(1));
DL_theta2=(loglike([theta_hat(1);theta_hat(2)*(1+step);theta_hat(3)])-loglike(theta_hat))/(step*theta_hat(2));
DL_theta3=(loglike([theta_hat(1);theta_hat(2);theta_hat(3)*(1+step)])-loglike(theta_hat))/(step*theta_hat(3));
DL=[DL_theta1,DL_theta2,DL_theta3];

% Using the derivatives above, I calculate the variance-covariance matrix and then the standard errors.

V=inv(transpose(DL)*DL);
SE_theta=zeros(size(theta_hat,1),1);
for i=1:size(theta_hat,1)
SE_theta(i)=sqrt(V(i,i));
end


