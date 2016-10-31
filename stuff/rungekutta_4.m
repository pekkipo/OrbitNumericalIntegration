function[rk_position]=rungekutta_4(t,y0)
%yp = yprime2(t, y0);
h = 50; %step

rk_position=zeros(length(y0),length(t));
rk_position(:,1)=y0;

for i = 2:length(t)

k1 = h.*yprime(t(i-1), rk_position(:,i-1));
k2 = h.*(yprime(t(i-1)+h/2, rk_position(:,i-1)+k1/2));
k3 = h.*(yprime(t(i-1)+h/2, rk_position(:,i-1)+k2/2));
k4 = h.*yprime(t(i-1)+h, rk_position(:,i-1)+k3);
rk_position(:,i)=rk_position(:,i-1)+1/6*(k1+2*k2+2*k3+k4);
end