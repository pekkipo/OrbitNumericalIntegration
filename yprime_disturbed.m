function yp_disturbed = yprime_disturbed(t,y0)
%the first derivative of y
% yois initial parameters of y
J=0.00108263;
ae=6378000; %m
GM=398.6005*10^12;
yp_disturbed=zeros(6,1);
yp_disturbed(1)=y0(4);
yp_disturbed(2)=y0(5);
yp_disturbed(3)=y0(6);
R=sqrt(y0(1)^2+y0(2)^2+y0(3)^2);
flattening_x = (1-(((3/2)*J*(ae^2)/R^2)*(5*((y0(3)/R)^2)-1)));
flattening_y = (1-(((3/2)*J*(ae^2)/R^2)*(5*((y0(3)/R)^2)-1)));
flattening_z = (1-(((3/2)*J*(ae^2)/R^2)*(5*((y0(3)/R)^2)-3)));
yp_disturbed(4)=-GM/R^3*y0(1)*flattening_x;
yp_disturbed(5)=-GM/R^3*y0(2)*flattening_y;
yp_disturbed(6)=-GM/R^3*y0(3)*flattening_z;
end

%(1-(((3/2)*J*((ae^2)/(y0(1))^2))*(5*((y0(3)/y0(1))^2)-1)))
%(1-(((3/2)*J*(ae^2)/y0(1))*(5*((y0(3)/y0(1))^2)-1)));
%(1-(((3/2)*J*(ae^2)/y0(1)^2)*(5*((y0(3)/y0(1))^2)-1)))
%(1-(((3/2)*J*(ae^2)/y0(1)^2)*thing))
% flattening_x = (1-(((3/2)*J*(ae^2)/y0(1)^2)*(5*((y0(3)/R)^2)-1)));%wrong
% flattening_y = (1-(((3/2)*J*(ae^2)/y0(2)^2)*(5*((y0(3)/R)^2)-1)));
% flattening_z = (1-(((3/2)*J*(ae^2)/y0(3)^2)*(5*((y0(3)/R)^2)-3)));