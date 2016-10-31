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
%t = [1:5:3*T0 1:50:3*T0 1:500:3*T0]
%t=1:5:3*T0;
prompt = 'Enter quantity of steps (5,50,500) ';
result = input(prompt);
t=1:result:3*T0;


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
%[tour y23] = ode23('yprime_disturbed',t,y0);
[tour y45] = ode45('yprime_disturbed',t,y0);
%[tour y113] = ode113('yprime_disturbed',t,y0);

%% Plotting
% figure(1)
% plot3(y(:,1),y(:,2),y(:,3),'.')

analytical_orbit_matrix = [position(1,:);position(2,:);position(3,:);velocity(1,:);velocity(2,:);velocity(3,:)]';
%difference_matrix_23=analytical_orbit_matrix-y23;
difference_matrix_45=analytical_orbit_matrix-y45;
%difference_matrix_113=analytical_orbit_matrix-y113;

%% Difference plotting, ode23
% figure(2)
% subplot(2,1,1)
% plot(t,difference_matrix_23(:,1), 'r')  %with tour instead of t its the same
% hold on
% plot(t,difference_matrix_23(:,2), 'g')
% hold on
% plot(t,difference_matrix_23(:,3), 'b')
% hold off
% figure(2)
% subplot(2,1,2)
% plot(t,(difference_matrix_23(:,4)), 'r')
% hold on
% plot(t,(difference_matrix_23(:,5)), 'g')
% hold on
% plot(t,(difference_matrix_23(:,6)), 'b')
% hold off

%% Difference plotting, ode45
figure(3)
subplot(2,1,1)
plot(t,difference_matrix_45(:,1), 'r')  %with tour instead of t its the same
hold on
plot(t,difference_matrix_45(:,2), 'g')
hold on
plot(t,difference_matrix_45(:,3), 'b')
hold off
figure(3)
subplot(2,1,2)
plot(t,(difference_matrix_45(:,4)), 'r')
hold on
plot(t,(difference_matrix_45(:,5)), 'g')
hold on
plot(t,(difference_matrix_45(:,6)), 'b')
hold off


%% Difference plotting, ode113
% figure(4)
% subplot(2,1,1)
% plot(t,difference_matrix_113(:,1), 'r')  %with tour instead of t its the same
% hold on
% plot(t,difference_matrix_113(:,2), 'g')
% hold on
% plot(t,difference_matrix_113(:,3), 'b')
% hold off
% figure(4)
% subplot(2,1,2)
% plot(t,(difference_matrix_113(:,4)), 'r')
% hold on
% plot(t,(difference_matrix_113(:,5)), 'g')
% hold on
% plot(t,(difference_matrix_113(:,6)), 'b')
% hold off

%% Plots info
figure(2)
subplot(2,1,1)
title('Position difference. Analytical and numerical methods. ode23');
legend('x-position','y-position','z-position','Location','northwest');
xlabel('t(s)');
ylabel('Position difference(m)');
grid on
figure(2)
subplot(2,1,2)
title('Velocity difference. Analytical and numerical methods ode23');
legend('x-velocity','y-velocity','z-velocity','Location','northwest');
xlabel('t(s)');
ylabel('Velocity difference(m)');
grid on

figure(3)
subplot(2,1,1)
title('Position difference. Analytical and numerical methods, ode45');
legend('x-position','y-position','z-position','Location','northwest');
xlabel('t(s)');
ylabel('Position difference(m)');
grid on
figure(3)
subplot(2,1,2)
title('Velocity difference. Analytical and numerical methods, ode45');
legend('x-velocity','y-velocity','z-velocity','Location','northwest');
xlabel('t(s)');
ylabel('Velocity difference(m)');
grid on

figure(4)
subplot(2,1,1)
title('Position difference. Analytical and numerical methods, ode113');
legend('x-position','y-position','z-position','Location','northwest');
xlabel('t(s)');
ylabel('Position difference(m)');
grid on
figure(4)
subplot(2,1,2)
title('Velocity difference. Analytical and numerical methods, ode113');
legend('x-velocity','y-velocity','z-velocity','Location','northwest');
xlabel('t(s)');
ylabel('Velocity difference(m)');
grid on