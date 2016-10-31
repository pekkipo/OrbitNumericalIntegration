function yp = aren ( t, y, mu ),
% Aren
%
% This m-file is part of the material of the lecture
%   "Numerik gewoehnlicher Differentialgleichungen"
% at the Math Department of Munich University of Technology.
% Winter term 2000/01, Remark (2.26)
%
% Author :      PD Dr. Martin Arnold, martin.arnold@dlr.de
% Version of :  Oct, 27, 2000
%
% Right hand side for three body problem
%
% Reference:
%   E. Hairer, S.P. Norsett, G. Wanner
%   Solving Ordinary Differential Equations I, 2nd rev. ed.,
%   Springer Berlin Heidelberg New York, 1993, pp. 129f.
%
% Parameters:
%   t      (input)  : time
%   y      (input)  : actual positions and velocities
%   flag   (-)      : not used
%   mu     (input)  : mass parameter \mu
%   yp     (output) : actual value of the right hand side
%
% Example:
%   y0 = [ 0.994, 0, 0, -2.0015851063790825 ]';
%   te = 17.06521656015796255889;
%   nt = 501;   tspan = linspace ( 0, te, nt )';
%   [ t, y ] = ode45 ( 'aren', tspan, y0 );
%   plot ( y(:,1), y(:,3), 'b' );

% -> allocate memory for source term and output
yp = zeros ( size(y) );

% -> read vector of unknowns
y1  = y(1);
y1p = y(2);
y2  = y(3);
y2p = y(4);

% -> evaluate right hand side
d1 = ((y1+mu)^2+y2^2)^1.5;
d2 = ((y1-(1-mu))^2+y2^2)^1.5;

yp(1) = y1p;
yp(2) = y1 + 2*y2p - (1-mu)*(y1+mu)/d1 - mu*(y1-(1-mu))/d2;
yp(3) = y2p;
yp(4) = y2 - 2*y1p - (1-mu)*y2/d1 - mu*y2/d2;
