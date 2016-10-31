function [position,velocity,vel_magnitude] = kep2cart(t,per,asc,i,e,a)
%% Parameters
GM = 398.6005 * 10^12;      
%% Polar coordinates function
[r,v] = kep2orb(t,a,e)
%% Position Vectors
rbx=r.*cos(v);
rby=r.*sin(v);
rbz=r.*0;
rb=[rbx;rby;rbz];
%% Velocity Vectors
vb_x=sqrt(GM/(a*(1-e^2)))*(-sin(v));
vb_y=sqrt(GM/(a*(1-e^2)))*(e+cos(v));
vb_z=sqrt(GM/(a*(1-e^2)))*zeros(1,length(v));
vb=[vb_x;vb_y;vb_z];
%% Rotational Matrices
R3_per = [cos(-per) sin(-per) 0; -sin(-per) cos(-per) 0; 0 0 1 ];
R1_i = [ 1 0 0; 0 cos(-i) sin(-i); 0 -sin(-i) cos(-i)];
R3_asc = [ cos(-asc) sin(-asc) 0; -sin(-asc) cos(-asc) 0; 0 0 1];
%% Position, Velocity, Velocity Magnitude
position = (R3_asc)*(R1_i)*(R3_per)*rb;
velocity = (R3_asc)*(R1_i)*(R3_per)*vb;
vel_magnitude = sqrt(velocity(1,:).*velocity(1,:)+velocity(2,:).*velocity(2,:)+velocity(3,:).*velocity(3,:));

% first_step = (R3_per)*rb;
% second_step = (R1_i)*(first_step);
% position = (R3_asc)*(second_step);
% 
% first_stepv = (R3_per)*vb;
% second_stepv = (R1_i)*(first_stepv);
% velocity = (R3_asc)*(second_stepv);
% vel_magnitude = sqrt(velocity(1,:).*velocity(1,:)+velocity(2,:).*velocity(2,:)+velocity(3,:).*velocity(3,:));
end


