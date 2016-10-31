function error = arenrun(y0, t0, tn, mu, exact, dim, TOL)

h0 = tn - t0;
plotx = y0(1);
ploty = y0(3);
yold = y0;
yvec = [y0];
h = 0.5*h0;
hvec = [];
t = t0;
tvec = [t0];
k1old = AREN(t, yold, mu);
count = 1;
while (t < tn)
  tnew = t + h;
  [y, est, k1] = RK43(t, yold, h, k1old, dim, mu);
  count = count + 4;
  tau = min([5*h, h0, (0.9*TOL/norm(est)).^0.2*h]);
  if (norm(est) < TOL)
    t = tnew;
    hvec = [hvec; h]; 
    tvec = [tvec; t];
    h = min(tau, tn - t);
    yold = y;
    k1old = k1;
    plotx = [plotx; y(1)];
    ploty = [ploty; y(3)];
  else
    h = tau;
  end
end

clf;
subplot(6,1,1);
plot(tvec, 0*tvec, '.', 'markersize', 18);
set(gca, 'YTick', [], 'fontsize', 18);
xlim([0 tn]);

figure;
plot(plotx,ploty,'r-','linewidth',3);
hold on;
plot(-mu,0,'o','linewidth',8,'MarkerFaceColor','b');
plot(1-mu,0,'o','linewidth',3,'MarkerFaceColor','b');
set(gca,'fontsize',24);
title('Eingebettetes Runge-Kutta Verfahren RK4(3)','FontSize',16,'Color','b');
c = sprintf('TOL = %.0e,  Schritte = %d', TOL, count);
ht = legend(c,3);
set(ht, 'fontsize', 14);

fprintf('h_min = %.2e\n', min(hvec));
fprintf('h_max = %.2e\n', max(hvec));
fprintf('h_avg = %.2e\n', mean(hvec));
tn/length(tvec);
error = ORTNORM(exact - y);

% Ausgabe der Schritte und des Fehlers
steps = count
error
return;