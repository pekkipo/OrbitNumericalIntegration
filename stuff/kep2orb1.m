function[r,v,M,E]=kep2orb(t,a,e)
%This function calculates polar coordinates (r) and true anomalies (v) based
%on input orbital elements.
% t = observed time
% a = semi-major axis
% e = eccentricity
% E = eccentric anomaly
% M = mean anomaly
% GM = Geocentric gravitational constant
% n = mean motion (average angular velocity) [rad/s]
% sat = corresponding satellite

%% Parameters
GM = 398.6005 * 10^12;          
n = sqrt(GM/(a^3));                 
M = n*t;                    

%% Michibiki's mean anomaly at t0=0s is 30 degrees (pi/6 rad):

 
%% Calculating eccentric anomaly (E) using Kepler's equation (M=E-e*sin(E)) and iteration
%  Initial value E0=M, and the iteration is continued until E1-E0 is smaller than 10^(-6)

E(1:length(M))=0;
for ee = 1:length(M)
E0 = M(ee);
E1 = M(ee) + e*sin(E0);
while abs(E1-E0) > 10^(-10)
     E0 = E1;
     E1 = M(ee) + e*sin(E0);
end
E(ee)=E1;
end

%% Calculating radius and true anomaly with the following equations:
r=a*(1-e*cos(E));
v=2*atan(sqrt((1+e)/(1-e))*tan(E/2));
end
