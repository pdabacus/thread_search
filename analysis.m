% make nice looking plot of time vs num threads
% @file analysis.m
% @author Pavan Dayal

% load the data
data = load('data.txt');
n = data(:,1);
t = data(:,2);
N = numel(n);
a = min(n);
b = max(n);

% fit: y = A x^r
params = [ones(N,1), log(n)] \ log(t);
A = exp(params(1));
r = params(2);
fitx = linspace(a, b, 200)';
fity = A * fitx.^r;
lbl = sprintf('(%.4f) x^{(%.4f)}', A, r);

% plot data
resx = 1280;
resy = 720;
H = figure('position', [1,1,resx,resy]);
hold on;

plot(n, t, 'x', ...
    'displayname', 'measurements', ...
    'color', [214/255, 39/255, 40/255], ...
    'linewidth', 3, ...
    'markersize', 12 ...
);

%loglog(fitx, fity, '-', ...
%    'displayname', ['power curve: ', lbl], ...
%    'color', [31/255, 119/255, 180/255], ...
%    'linewidth', 4 ...
%);

%xticks([1,2,4,8,16,32,64]);
%xticklabels({'1', '2', '4', '8', '16', '32', '64'});
xlim([a,b]);
%ylim([0,max(t)]);

L = legend();
set(L, ...
    'fontsize', 18, ...
    'linewidth', 2, ...
    'textcolor', [0.2, 0.2, 0.2] ...
);

% https://octave.org/doc/v4.2.2/Axes-Properties.html
set(get(H, 'currentaxes'), ...
    'fontsize', 16, ...
    'linewidth', 2, ...
    'xcolor', [120/255,120/255,120/255], ...
    'ycolor', [120/255,120/255,120/255], ...
    'box', 'on', ...
    'xgrid', 'on', ...
    'ygrid', 'on', ...
    'gridalpha', 0.1 ...
);

% https://octave.org/doc/v4.2.2/Text-Properties.html
Xl = xlabel('number of threads', ...
    'fontweight', 'normal', ...
    'fontsize', 28, ...
    'color', [0.2, 0.2 ,0.2] ...
);

ylabel('time (s)', ...
    'fontweight', 'normal', ...
    'fontsize', 28, ...
    'color', [0.2, 0.2 ,0.2] ...
);

title('time for word searches vs number of threads', ...
    'fontweight', 'normal', ...
    'fontsize', 32, ...
    'color', [0.2, 0.2, 0.2] ...
);

print('plot.png', '-dpng', sprintf('-S%d,%d', resx, resy));
