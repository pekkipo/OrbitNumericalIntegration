function varargout = arenmenu(varargin)
% Das Programm berechnet mittels eines eingebetteten Runge-Kutta
% 4(3) Verfahrens die Loesung des restringierten
% Dreikoerperproblems.
% Ueber eine Menueauswahl koennen verschiedene Orbits erzeugt und
% unterschiedliche Toleranzwerte fuer das Verfahren eingegeben werden.
%
% Das eingebettete Runge-Kutta Verfahren findet sich in:
% Peter Deuflhard, Folkmar Bornemann
% Numerische Mathematik. 2: Gewöhnliche Differentialgleichungen.
% De Gruyter, Berlin, 1994.
%
% Autoren: Bernd Flemisch und Stefan Hueeber
% {flemisch, hueeber}@mathematik.uni-stuttgart.de
% Version 2.0
% 24.10.2002

% Last Modified by GUIDE v2.0 24-Oct-2002 20:39:13

if nargin == 0  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

	% Use system color scheme for figure:
	set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
	guidata(fig, handles);

	if nargout > 0
		varargout{1} = fig;
	end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
	catch
		disp(lasterr);
	end

end


function varargout = Solve_Callback(h, eventdata, handles, varargin)
close all;
dim = 4;
t0 = 0;
y0 = zeros(4,1);
y0(1) = str2double(get(handles.x0,'String'));
y0(2) = str2double(get(handles.vx0,'String'));
y0(3) = str2double(get(handles.y0,'String'));
y0(4) = str2double(get(handles.vy0,'String'));
tn = str2double(get(handles.T,'String'));
mu = str2double(get(handles.mu,'String'));
exact = y0;
if (get(handles.tol2, 'Value') == 1) TOL = 1e-2; end;   
if (get(handles.tol3, 'Value') == 1) TOL = 1e-3; end;   
if (get(handles.tol4, 'Value') == 1) TOL = 1e-4; end;   
if (get(handles.tol5, 'Value') == 1) TOL = 1e-5; end;   
err = arenrun(y0, t0, tn, mu, exact, dim, TOL);
return;

% --------------------------------------------------------------------
function varargout = x0_Callback(h, eventdata, handles, varargin)
return;

% --------------------------------------------------------------------
function varargout = vx0_Callback(h, eventdata, handles, varargin)
return;

% --------------------------------------------------------------------
function varargout = y0_Callback(h, eventdata, handles, varargin)
return;

% --------------------------------------------------------------------
function varargout = vy0_Callback(h, eventdata, handles, varargin)
return;

% --------------------------------------------------------------------
function varargout = T_Callback(h, eventdata, handles, varargin)
return;

% --------------------------------------------------------------------
function varargout = mu_Callback(h, eventdata, handles, varargin)
return;

% --------------------------------------------------------------------
function varargout = dreiblaettrig_Callback(h, eventdata, handles, varargin)
set(h,'Value',1);
off = handles.vierblaettrig;
set(off,'Value',0);
off = handles.Schleife;
set(off,'Value',0);
off = handles.Knaeuel;
set(off,'Value',0);
off = handles.DIY;
set(off,'Value',0);
off = handles.x0;
set(off,'Enable','inactive');
off = handles.vx0;
set(off,'Enable','inactive');
off = handles.y0;
set(off,'Enable','inactive');
off = handles.vy0;
set(off,'Enable','inactive');
off = handles.T;
set(off,'Enable','inactive');
off = handles.mu;
set(off,'Enable','inactive');
set(handles.x0, 'String', '0.994');
set(handles.vx0, 'String', '0.0');
set(handles.y0, 'String', '0.0');
set(handles.vy0,'String','-2.0317326295573368357302057924');
set(handles.mu,'String','0.012277471');
set(handles.T,'String','11.124340337266085134999734047');
set(handles.x0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.vx0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.y0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.vy0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.T, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.mu, 'BackgroundColor', [0.75, 0.75, 0.75]);
return;


% --------------------------------------------------------------------
function varargout = vierblaettrig_Callback(h, eventdata, handles, varargin)
set(h,'Value',1);
off = handles.dreiblaettrig;
set(off,'Value',0);
off = handles.Schleife;
set(off,'Value',0);
off = handles.Knaeuel;
set(off,'Value',0);
off = handles.DIY;
set(off,'Value',0);
off = handles.x0;
set(off,'Enable','inactive');
off = handles.vx0;
set(off,'Enable','inactive');
off = handles.y0;
set(off,'Enable','inactive');
off = handles.vy0;
set(off,'Enable','inactive');
off = handles.T;
set(off,'Enable','inactive');
off = handles.mu;
set(off,'Enable','inactive');
set(handles.x0, 'String', '0.994');
set(handles.vx0, 'String', '0.0');
set(handles.y0, 'String', '0.0');
set(handles.vy0,'String','-2.0015851063790825');
set(handles.mu,'String','0.012277471');
set(handles.T,'String','17.06521656015796255889');
set(handles.x0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.vx0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.y0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.vy0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.T, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.mu, 'BackgroundColor', [0.75, 0.75, 0.75]);
return;


% --------------------------------------------------------------------
function varargout = Schleife_Callback(h, eventdata, handles, varargin)
set(h,'Value',1);
off = handles.vierblaettrig;
set(off,'Value',0);
off = handles.dreiblaettrig;
set(off,'Value',0);
off = handles.Knaeuel;
set(off,'Value',0);
off = handles.DIY;
set(off,'Value',0);
off = handles.x0;
set(off,'Enable','inactive');
off = handles.vx0;
set(off,'Enable','inactive');
off = handles.y0;
set(off,'Enable','inactive');
off = handles.vy0;
set(off,'Enable','inactive');
off = handles.T;
set(off,'Enable','inactive');
off = handles.mu;
set(off,'Enable','inactive');
set(handles.x0, 'String', '0.994');
set(handles.vx0, 'String', '0.0');
set(handles.y0, 'String', '0.0');
set(handles.vy0,'String','-2.1245');
set(handles.mu,'String','0.0121486');
set(handles.T,'String','5.44');
set(handles.x0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.vx0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.y0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.vy0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.T, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.mu, 'BackgroundColor', [0.75, 0.75, 0.75]);
return;


% --------------------------------------------------------------------
function varargout = Knaeuel_Callback(h, eventdata, handles, varargin)
set(h,'Value',1);
off = handles.vierblaettrig;
set(off,'Value',0);
off = handles.Schleife;
set(off,'Value',0);
off = handles.dreiblaettrig;
set(off,'Value',0);
off = handles.DIY;
set(off,'Value',0);
off = handles.x0;
set(off,'Enable','inactive');
off = handles.vx0;
set(off,'Enable','inactive');
off = handles.y0;
set(off,'Enable','inactive');
off = handles.vy0;
set(off,'Enable','inactive');
off = handles.T;
set(off,'Enable','inactive');
off = handles.mu;
set(off,'Enable','inactive');
set(handles.x0, 'String', '1.15');
set(handles.vx0, 'String', '0.0');
set(handles.y0, 'String', '0.0');
set(handles.vy0,'String','0.00761');
set(handles.mu,'String','0.0121486');
set(handles.T,'String','29.5');
set(handles.x0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.vx0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.y0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.vy0, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.T, 'BackgroundColor', [0.75, 0.75, 0.75]);
set(handles.mu, 'BackgroundColor', [0.75, 0.75, 0.75]);
return;


% --------------------------------------------------------------------
function varargout = DIY_Callback(h, eventdata, handles, varargin)
off = handles.vierblaettrig;
set(off,'Value',0);
off = handles.Schleife;
set(off,'Value',0);
off = handles.Knaeuel;
set(off,'Value',0);
off = handles.dreiblaettrig;
set(off,'Value',0);
off = handles.x0;
set(off,'Enable','on');
off = handles.vx0;
set(off,'Enable','on');
off = handles.y0;
set(off,'Enable','on');
off = handles.vy0;
set(off,'Enable','on');
off = handles.T;
set(off,'Enable','on');
off = handles.mu;
set(off,'Enable','on');
set(handles.x0, 'BackgroundColor', 'w');
set(handles.vx0, 'BackgroundColor', 'w');
set(handles.y0, 'BackgroundColor', 'w');
set(handles.vy0, 'BackgroundColor', 'w');
set(handles.T, 'BackgroundColor', 'w');
set(handles.mu, 'BackgroundColor', 'w');
return;

% --------------------------------------------------------------------
function varargout = tol2_Callback(h, eventdata, handles, varargin)
set(h,'Value',1);
off = handles.tol3;
set(off,'Value',0);
off = handles.tol4;
set(off,'Value',0);
off = handles.tol5;
set(off,'Value',0);

% --------------------------------------------------------------------
function varargout = tol3_Callback(h, eventdata, handles, varargin)
set(h,'Value',1);
off = handles.tol2;
set(off,'Value',0);
off = handles.tol4;
set(off,'Value',0);
off = handles.tol5;
set(off,'Value',0);

% --------------------------------------------------------------------
function varargout = tol4_Callback(h, eventdata, handles, varargin)
set(h,'Value',1);
off = handles.tol3;
set(off,'Value',0);
off = handles.tol2;
set(off,'Value',0);
off = handles.tol5;
set(off,'Value',0);

% --------------------------------------------------------------------
function varargout = tol5_Callback(h, eventdata, handles, varargin)
set(h,'Value',1);
off = handles.tol3;
set(off,'Value',0);
off = handles.tol4;
set(off,'Value',0);
off = handles.tol2;
set(off,'Value',0);




% --------------------------------------------------------------------
function varargout = figure1_ResizeFcn(h, eventdata, handles, varargin)
% Stub for ResizeFcn of the figure handles.figure1.
disp('figure1 ResizeFcn not implemented yet.')