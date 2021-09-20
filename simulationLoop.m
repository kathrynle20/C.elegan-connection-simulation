% drawing
draw_on = 1;
pause_on = 0; % enable for regular pausing.

% set trial duration
duration = 2000;
pause_interval = 5000;

% viewing window size
window_size = 5000;


% set population parameters
Nn = size(A,1); % total population size

avgList = [];
avgDiff = [];

%nChanged = [0 2 4 6 8 10 12 14 16 18 20];
nChanged = [0 1 2 3 4 5 6 7 8 9 10];

for c = [0 2 4 6 8 10 12 14 16 18 20]
    activitySum = zeros(Nn, Nn);
    times = 0;

for z = 1:100
    times = times + 1;
    
    % reset params
    x = zeros(Nn, 1);
    activities = zeros(Nn, duration);
    
    W = A';
    W = W>0;
    % Ww = W>0;%
    
    matrixSize = size(W);
    
    change = c;
    Rstart = 1;
    Rend = matrixSize(1);
    Cstart = 1;
    Cend = matrixSize(2);
    
    [W, changed] = removeRandConGap(W,change,Rstart,Rend,Cstart,Cend);
    
    into_weights = sum(W, 2)';
    into_weights_alt = into_weights;
    into_weights_alt(into_weights_alt==0)=0.5;
    
    position_flag = 1;
    activation_threshold = 0.5;
    threshold = activation_threshold * ones(Nn, 1);
    mean = 0.4;
    std = 0.05;
    % main simulation loop
    for t = 1:duration 
        background_rate = max(normrnd(mean, std, [Nn, 1]), 0);
        
        %save previous firings    
        x = heaviside_origin(W*x - (threshold(1:Nn) .* into_weights_alt') + ((into_weights_alt') .* background_rate(1:Nn)) .* randi([-1 ,1],Nn,1) );
        
        activities(:, t) = x;
        
    end
    
    h = corrcoef(activities(:,1:duration).');
    activitySum = activitySum + h;
    disp(z)
end

%{
clf(figure(3))
figure(3);
%}

avg = activitySum/times;
avgD = sum(avg,'all')/600;
avgList = [avgList avg];
avgDiff = [avgDiff avgD];
%{
out = avg;
out(abs(out)<0.05)=0;
fig3 = heatmap(out,'Colormap',jet,'ColorLimits',[0 1]);
grid off
ax = gca;
ax.XData = order;
ax.YData = order;
ax.FontSize = 7;
ylabel('Neurons'); xlabel('Neurons');
title('Pearson correlation');
%}
disp(c)
end