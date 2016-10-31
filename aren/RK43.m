function [ynew, est, k1new] = rk43(t, y, h, k1, dim, mu)

k2 = AREN(t + 0.5*h, y + 0.5*h*k1, mu);
k3 = AREN(t + 0.5*h, y + 0.5*h*k2, mu);
k4 = AREN(t + h, y + h*k3, mu);
k1new = AREN(t + h, y + h*(1/6*k1 + 2/6*k2 + 2/6*k3 + 1/6*k4), mu);
ynew = y + h*(1/6*k1 + 2/6*k2 + 2/6*k3 + 1/6*k4);
for i = 1:dim
  sigma = max(1e-7, abs(y(i)));
  est(i) = (k4(i) - k1new(i))/6/sigma;
end
if (~est) est = eps; end
return