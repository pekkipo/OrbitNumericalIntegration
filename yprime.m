function yp =yprime(t,y0)
%the first derivative of y
% yois initial parameters of y
GM=398.6005*10^12;
yp=zeros(6,1);
yp(1)=y0(4);
yp(2)=y0(5);
yp(3)=y0(6);
R=sqrt(y0(1)^2+y0(2)^2+y0(3)^2);
yp(4)=-GM/R^3*y0(1);
yp(5)=-GM/R^3*y0(2);
yp(6)=-GM/R^3*y0(3);
end