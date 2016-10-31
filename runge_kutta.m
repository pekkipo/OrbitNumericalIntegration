function y = runge_kutta(t,y0)

h=50;

y=zeros(length(y0),length(t));
y(:,1)=y0;

%y=zeros(6,1);
for i=2:length(t)
    k1=h.*yprime(t(i-1),y(:,i-1));
    k2=h.*(yprime(t(i-1)+h/2,y(:,i-1)+k1/2));
    k3=h.*(yprime(t(i-1)+h/2,y(:,i-1)+k2/2));
    k4=h.*yprime(t(i-1)+h,y(:,i-1)+k3);
    y(:,i)=y(:,i-1) +1/6*(k1+2*k2+2*k3+k4);
end
%y=y(i,:);

end
% 
% rk_position=zeros(length(y0),length(t));
% rk_position(:,1)=y0;
% 
% for i = 2:length(t)
% 
% k1 = h.*yprime(t(i-1), rk_position(:,i-1));
% k2 = h.*(yprime(t(i-1)+h/2, rk_position(:,i-1)+k1/2));
% k3 = h.*(yprime(t(i-1)+h/2, rk_position(:,i-1)+k2/2));
% k4 = h.*yprime(t(i-1)+h, rk_position(:,i-1)+k3);
% rk_position(:,i)=rk_position(:,i-1)+1/6*(k1+2*k2+2*k3+k4);
% end

% y=yprime(t,y0);
% h=5;
% %y=zeros(6,1);
% for i=1:length(t)
%     k1=h*yprime(t,y0);
%     k2=h*yprime(t+h/2,y0+k1/2);
%     y(i,:)=y0+k2;
%     y0=y(i,1);
%     y0=y0; 
% end
% y=y(i,:);


% for i=1:length(t)
%     k1=h*yprime(t,y0);
%     k2=h*yprime(t+h/2,y0+k1/2);
% %     k3=h*yprime(t+h/2,y0+k2/2);
% %     k4=h*yprime(t+h,y0+k3);
%     %y(i,:)=y0 +(1/6)*(k1+2*k2+2*k3+k4);
%     y(i,:)=y0+k2;
%     y0=y(i,:); %prevoius y(i) becomes y0 for the next point
%     y0=y0'; 
%     y1=y(i,:);
%     %y1=y(i,:);
% end

