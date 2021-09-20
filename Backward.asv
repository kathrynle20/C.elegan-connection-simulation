addpath functions
T = readtable("Backwards Chemical Hernans symmetry.tsv",'FileType',"text");
%T = readtable ("Backwards Chemical No Symmetry Varshney Weights.tsv",'FileType',"text");
G = digraph(table2array(T(:,1)),table2array(T(:,2)),table2array(T(:,3)));
A = full(adjacency(G,"weighted"));
Forward_gap_order = {'DB05';'DB06';'DB07';'VB10';'VB11';'DB04';'VB02';'DB01';'VB04';'DB03';'VB05';'DB02';'VB01';'VB06';'VB07';'VB03';'VB08';'VB09';'RIBL';'RIBR';'AVBL';'AVBR'};
Backward_gap_order = {'VA02';'VA03';'VA06';'VA07';'VA08';'VA09';'VA10';'VA11';'VA12';'DA03';'DA06';'DA07';'DA05';'DA09';'DA08';'DA04';'DA01';'VA01';'DA02';'VA04';'VA05';'RIML';'RIMR';'AIBL';'AIBR';'AVEL';'AVER';'AVAL';'AVAR'};
Forward_chem_order = {'VB03';'VB04';'VB05';'VB10';'VB11';'DB07';'DB06';'DB03';'DB04';'DB02';'VB06';'VB07';'VB08';'VB09';'AVBL';'AVBR';'RIBR';'RIBL';'PVCL';'PVCR'};
Backward_chem_order = {'DA05';'DA08';'DA09';'VA06';'VA11';'VA12';'VA10';'DA07';'DA06';'DA01';'DA02';'DA03';'DA04';'VA02';'VA03';'VA04';'VA05';'VA01';'VA08';'VA09';'AVEL';'AVER';'AVAL';'AVAR';'AVDL';'AVDR';'AIBL';'AIBR';'RIML';'RIMR'};
order = Backward_chem_order;
tbl = array2table(A,"RowNames",table2array(G.Nodes),"VariableNames",table2array(G.Nodes));
A = table2array(tbl(order,order));
tic

% drawing
draw_on = 1;
pause_on = 0; % enable for regular pausing.

% set trial duration
duration = 20000;
pause_interval = 5000;

% viewing window size
window_size = 5000;


% set population parameters
Nn = size(A,1); % total population size

% reset params
x = zeros(Nn, 1);
activities = zeros(Nn, duration);

W = A';
W = W>0;
% Ww = W>0;%

change = 16;
Rstart = 1;
Rend = 30;
Cstart = 1;
Cend = 30;

[W, changed] = restrictedRandCon(W,change,Rstart,Rend,Cstart,Cend);

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
    
    
    % plot intermediate activity
    if mod(t, pause_interval) == 0
        if draw_on
            activities_sorted = activities(:, max(1, t - window_size):t);
            
            
            figure(1); clf;
            hold on;
            xlim([0, window_size]);
            ylim([0, Nn + 1]);
            for i = 1:Nn
                ac = find(activities_sorted(i, :));
                scatter(ac, i*ones(1, length(ac)), 8, 'black', 'o',  'filled');
            end
            box on;
            set(gca, 'linewidth', 3, 'YTick', 1:1:Nn, 'YTickLabel',cellstr(order), 'FontSize', 7)
            set(gca,'linewidth', 3,'xtick', 0:100:window_size, 'xticklabel', t-window_size:100:t)
            ylabel('Neuron'); xlabel('Time steps');   
            title('Neuron firing per time step');
            set(gcf, 'color', 'white')
            if position_flag set(gcf, 'position', [388 488 560 420]); end;

            drawnow;
            if pause_on, pause(); end;
        end
    end
end

clf(figure(3))
figure(3);
h = corrcoef(activities(:,1:duration).');
%out = h - diag(diag(h));
out = h;
out(abs(out)<0.05)=0;
fig3 = heatmap(out,'Colormap',jet,'ColorLimits',[0 1]);
grid off
ax = gca;
ax.XData = order;
ax.YData = order;
ax.FontSize = 7;
ylabel('Neurons'); xlabel('Neurons');
title('Pearson correlation');


LR_pair = [];
remaining = [];
v=array2table(out,'VariableNames',order,'RowNames',order);
X = order;
for i = 1:size(X,1)
    Nnamei = convertStringsToChars(string(X(i,1)));
    for j = 1:size(X,1)
       Nnamej =  convertStringsToChars(string(X(j,1)));
       if Nnamei(end) == 'L' ||Nnamei(end) ==  'R'
           
           if Nnamej(end) == 'L' || Nnamej(end)=='R'             
                    
               if strcmp(Nnamei,Nnamej)
                    %Do not count self corrcoef
               elseif strcmp(Nnamej(1:end-1),Nnamei(1:end-1))
                    LR_pair = cat (2,LR_pair,v{Nnamei,Nnamej});
               else
                    remaining = cat (2,remaining,v{Nnamei,Nnamej});
               end
               
           else
               remaining = cat (2,remaining,v{Nnamei,Nnamej});   
           end
       else
           remaining = cat (2,remaining,v{Nnamei,Nnamej});
       end
    end
end

clf(figure(5))
figure(5);
map = brewermap(2,'Set2'); 
%histogram(remaining,'Normalization','count')
histogram(remaining,-0.1:.025:1,'facecolor',map(1,:),'facealpha',.5,'edgecolor','none','Normalization','probability')
hold on
%histogram(LR_pair,'Normalization','count')
histogram(LR_pair,-0.1:.025:1,'facecolor',map(2,:),'facealpha',.5,'edgecolor','none','Normalization','probability')
box off
axis tight
legend('Remaining','LR pairs','location','northwest')
legend boxoff

