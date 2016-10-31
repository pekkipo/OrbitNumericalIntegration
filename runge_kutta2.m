function rk= runge_kutta2(t,y0)
h=50;

rk=zeros(length(y0),length(t));
rk(:,1)=y0;

for i = 2:length(t)

k1 = h.*yprime(t(i-1), rk(:,i-1));
k2 = h.*(yprime(t(i-1)+h/2, rk(:,i-1)+k1/2));
k3 = h.*(yprime(t(i-1)+h/2, rk(:,i-1)+k2/2));
k4 = h.*yprime(t(i-1)+h, rk(:,i-1)+k3);
rk(:,i)=rk(:,i-1)+1/6*(k1+2*k2+2*k3+k4);

end












% for i=2:length(t)
%    
%     k1=h.*yprime(t(i-1),y1);
%     k2=h.*yprime(t(i-1)+h/2,y1+k1/2);
%     k3=h.*yprime(t(i-1)+h/2,y1+k2/2);
%     k4=h.*yprime(t(i-1)+h,y1+k3);
%     y(:,i)=y1(:,i-1)+(1/6)*(k1+2*k2+2*k3+k4);
%  
%     y1=y(:,i-1); %prevoius y(i) becomes y0 for the next point
%     %y1=y'; 
%    
% 
% end
% 
%   k1=h.*yprime(t(i-1),y0);
%     k2=h.*yprime(t(i-1)+h/2,y0+k1/2);
%     k3=h.*yprime(t(i-1)+h/2,y0+k2/2);
%     k4=h.*yprime(t(i-1)+h,y0+k3);
%     y(:,i)=y0 +(1/6)*(k1+2*k2+2*k3+k4);