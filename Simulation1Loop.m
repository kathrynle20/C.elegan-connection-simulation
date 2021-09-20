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
removed = [];

adjMatrixSize = size(order);
activitySum = zeros(adjMatrixSize(1),adjMatrixSize(1));


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
    
    change = 12;
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
    %original = avg0;
    %activityList = [activityList;z abs(h-original)];
    %avgEach = sum(h,'all')/600;
    %avgList = [avgList; avgEach];
    %index=[];
    %for numZ=1:change+1
    %for numZ=1:(change*2)+1
    %    index=[index;z];
    %end
    %index = [z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z;z];
    %index = [z;z;z;z;z;z;z;z;z;z;z];
    %index = [z,z,z];
    %removed = [removed; index changed];
    
    
    disp(z)
    
    
end

%avg = activitySum/times;
avg0 = activitySum/times;
avgD0 = sum(avg,'all')/600;



