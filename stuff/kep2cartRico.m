function[position,velocity]=kep2cart(i,o,w,t,a,e,sat)
GM=398.6005*10^12;
%% Calculation for position and velocity
[r,v]=kep2orb(t,a,e,sat)

%% Computing position vectors

rb_x=r.*cos(v);
rb_y=r.*sin(v);
rb_z=r.*0;
rb=[rb_x;rb_y;rb_z];

x1 = [cos(-w), sin(-w), 0; -sin(-w), cos(w), 0; 0, 0, 1] * rb;
x2 = [1 0 0; 0 cos(-i) sin(-i); 0 -sin(-i) cos(-i)] * x1;
position = [cos(-o), sin(-o), 0; -sin(-o), cos(-o), 0; 0, 0, 1] * x2;


%% Computing velocity vectors

vb_x=sqrt(GM/(a*(1-e^2)))*(-sin(v));
vb_y=sqrt(GM/(a*(1-e^2)))*(e+cos(v));
vb_z=sqrt(GM/(a*(1-e^2)))*zeros(1,length(v));
vb=[vb_x;vb_y;vb_z];

v1 = [cos(-w), sin(-w), 0; -sin(-w), cos(w), 0; 0, 0, 1] * vb;
v2 = [1 0 0; 0 cos(-i) sin(-i); 0 -sin(-i) cos(-i)] * v1;
velocity = [cos(-o), sin(-o), 0; -sin(-o), cos(-o), 0; 0, 0, 1] * v2;
end