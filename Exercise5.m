clc
clear all
close all

%% GOCE  Parameters
a = 6629000;
e = 0.004;
i = degtorad(96.6);
ascension = degtorad(257.7);
perigee_argument = degtorad(144.2);

GM = 398.6005 * 10^12;  
n = sqrt(GM/(a^3));         % mean motion = average angular velocity [rad/s] 
T0 = 2*pi*(1/n);            % one revolution
prompt = 'Enter required quantity of steps (5,50,500)';
result = input(prompt);
t=1:result:3*T0;

%% Getting position and velocity from function
[position velocity] = kep2cart(t,perigee_argument,ascension,i,e,a);

analytical_matrix = [position(1,:);position(2,:);position(3,:);velocity(1,:);velocity(2,:);velocity(3,:)];

%% Fill in the initial point matrix. 1 point with 3 position coordinates and
%3 velocity coordinates
y0=zeros(6,1);
y0(1) = position(1,1);
y0(2) = position(2,1);
y0(3) = position(3,1);
y0(4) = velocity(1,1);
y0(5) = velocity(2,1);
y0(6) = velocity(3,1);


%y=runge_kutta2(t,y0);

h=result;
y=zeros(length(y0),length(t));
y(:,1)=y0;
for i=2:length(t)
    k1=h*yprime(t,y0);
    k2=h*yprime(t+h/2,y0+k1/2);
    k3=h*yprime(t+h/2,y0+k2/2);
    k4=h*yprime(t+h,y0+k3);
    y(:,i)=y0 +(1/6)*(k1+2*k2+2*k3+k4);
    y0=y(:,i); %prevoius y(i) becomes y0 for the next point
end

difference_matrix = analytical_matrix - y;

figure(1)
%subplot(2,1,1)
plot3(y(1,:),y(2,:),y(3,:),'*r');
hold on
%subplot(2,1,2)
plot3(analytical_matrix(1,:),analytical_matrix(2,:),analytical_matrix(3,:),'.b');
%% Plotting
%% Difference plotting
figure(2)
subplot(2,1,1)
plot(t,difference_matrix(1,:), 'r')  %with tour instead of t its the same
hold on
plot(t,difference_matrix(2,:), 'g')
hold on
plot(t,difference_matrix(3,:), 'b')
hold on

figure(2)
subplot(2,1,2)
plot(t,(difference_matrix(4,:)), 'r')
hold on
plot(t,(difference_matrix(5,:)), 'g')
hold on
plot(t,(difference_matrix(6,:)), 'b')
hold on

% 
%% Plots info
figure(1)
title('Orbits. Analytical and RK4 methods.');
legend('Numericaly integrated','Analytically derived','Location','northwest');
grid on


figure(2)
subplot(2,1,1)
title('Position difference. Analytical and numerical methods. RK method, step 500');
legend('x-position','y-position','z-position','Location','northwest');
xlabel('t(s)');
ylabel('Position difference(m)');
grid on
figure(2)
subplot(2,1,2)
title('Velocity difference. Analytical and numerical methods. RK method, step 50');
legend('x-velocity','y-velocity','z-velocity','Location','northwest');
xlabel('t(s)');
ylabel('Velocity difference(m/s)');
grid on


