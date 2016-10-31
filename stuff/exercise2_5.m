close all
clear all

a=6629000;
e=0.004;
i=degtorad(96.6);
o=degtorad(257.7);
w=degtorad(144.2);
tau=0;
GM = 398.6005 * 10^12;  

n = sqrt(GM/(a^3));         % mean motion = average angular velocity [rad/s] 
T0 = 2*pi*(1/n);            % one revolution
t = 1:50:3*T0;                   % points for three revolution
sat = 1;

[position,velocity]=kep2cart(t,i,o,w,a,e);

analytical= [position(1,:); position(2,:); position(3,:); velocity(1,:); velocity(2,:); velocity(3,:)];

y0=zeros(6,1);
y0(1)=position(1,1);
y0(2)=position(2,1);
y0(3)=position(3,1);
y0(4)=velocity(1,1);
y0(5)=velocity(2,1);
y0(6)=velocity(3,1);

[rk_position]=rungekutta_4(t,y0);

difference = analytical - rk_position;

figure(1)
subplot(2,1,1);
plot(t,difference(1,:),'r');
hold on
plot(t,difference(2,:),'g');
hold on
plot(t,difference(3,:),'b');
title('Position difference between analytical and Runge-Kutta Method with 50 step size');
legend('x coordinate difference','y coordinate difference','z coordinate difference');
xlabel('Time sequence(s)');
ylabel('Difference (m)');
grid on;

subplot(2,1,2);
plot(t,difference(4,:),'r');
hold on
plot(t,difference(5,:),'g');
hold on
plot(t,difference(6,:),'b');
title('Velocity difference between undisturbed and Runge-Kutta Method with 50 step size');
legend('x velocity difference','y velocity difference','z velocity difference');
xlabel('Time sequence(s)');
ylabel('Difference (m/s)');
grid on;