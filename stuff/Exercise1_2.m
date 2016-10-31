clc
clear all
close all

%% GOCE  Parameters
a = 6629000;
e = 0.04;
i = degtorad(96.6);
ascension = degtorad(257.7);
perigee_argument = degtorad(144.2);

GM = 398.6005 * 10^12;  
n = sqrt(GM/(a^3));         % mean motion = average angular velocity [rad/s] 
T0 = 2*pi*(1/n);            % one revolution
t = 1:5:3*T0;
%Getting position and velocity from function
[position,velocity] = kep2cart(t,perigee_argument,ascension,i,e,a);
%% Fill in the initial point matrix. 1 point with 3 position coordinates and
%3 velocity coordinates
y0=zeros(6,1);
y0(1) = position(1,1);
y0(2) = position(2,1);
y0(3) = position(3,1);
y0(4) = velocity(1,1);
y0(5) = velocity(2,1);
y0(6) = velocity(3,1);

options = odeset('RelTol',1e-10,'AbsTol',1e-10);
%[tour y23]= ode23('yprime',t,y0);
%[tour y45] = ode45('yprime',t,y0);
[tour y] = ode45('yprime',t,y0);
%% Plotting
figure(1)
plot3(y(:,1),y(:,2),y(:,3),'.')

analytical_orbit_matrix = [position(1,:);position(2,:);position(3,:);velocity(1,:);velocity(2,:);velocity(3,:)]';
difference_matrix=analytical_orbit_matrix-y;

figure(2)
plot(t,difference_matrix(:,1), 'r')  %with tour instead of t its the same
hold on
plot(t,difference_matrix(:,2), 'g')
hold on
plot(t,difference_matrix(:,3), 'b')
hold off

figure(3)
plot(t,(difference_matrix(:,4)), 'r')
hold on
plot(t,(difference_matrix(:,5)), 'g')
hold on
plot(t,(difference_matrix(:,6)), 'b')
hold off

%% Plots info
figure(2)
title('Position difference. Analytical and numerical methods');
legend('x-position','y-position','z-position');
xlabel('t(s)');
ylabel('Position difference(m)');

figure(3)
title('Velocity difference. Analytical and numerical methods');
legend('x-velocity','y-velocity','z-velocity');
xlabel('t(s)');
ylabel('Velocity difference(m)');
