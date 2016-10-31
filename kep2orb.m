function[r, v,E,M]=kep2orb(t,a,e)
%% Original parameters
%Re = 6371 * 10^3;
GM = 398.6005 * 10^12;  
n = sqrt(GM/(a^3));         % mean motion = average angular velocity [rad/s] 
%T0 = 2*pi*(1/n);            % one revolution
%t = 1:3*T0;                   % points for one revolution
M = n*t;                    % mean anomaly
%% Michibiki has different mean anomaly:
E(1:length(M))=0;
%% Calculating E by iteration
for ii=1:length(M)                                                       
E0 = M(ii);
E1 = M(ii) + e*sin(E0);
while abs(E1-E0) > 10^(-10)
     E0 = E1;
     E1 = M(ii) + e*sin(E0);
end
E(ii)=E1;
end

%% Calculating radius and true anomaly
r = a*(1-e*cos(E));
v = 2*atan((sqrt((1+e)/(1-e)))*tan(E/2));

end
