%{
figure
p = plot(G,'Layout','force','EdgeAlpha',0.005,'NodeColor','r');
G = graph(A,order);
deg_ranks = centrality(G,'degree','Importance',G.Edges.Weight);
edges = linspace(min(deg_ranks),max(deg_ranks),15);
bins = discretize(deg_ranks,edges);
p.MarkerSize = bins;
title("Node Importance for Backward Gap")
%}

figure
p = plot(G,'Layout','force','EdgeAlpha',0.005,'NodeColor','r');
G = graph(A,order);
deg_ranks = centrality(G,'degree','Importance',G.Edges.Weight);
edges = linspace(min(deg_ranks),max(deg_ranks),15);
bins = discretize(deg_ranks,edges);
p.MarkerSize = bins;
title("Node Importance for Forward Gap")

%{
figure
p = plot(G,'Layout','force','EdgeAlpha',0.005,'NodeColor','r');
G = digraph(A, order);
deg_ranks = centrality(G,'outdegree','Importance',G.Edges.Weight);
edges = linspace(min(deg_ranks),max(deg_ranks),15);
bins = discretize(deg_ranks,edges);
p.MarkerSize = bins;
title("Out Degree Node Importance for Backward Chem")
%}
%{
figure
p = plot(G,'Layout','force','EdgeAlpha',0.005,'NodeColor','r');
G = digraph(A, order);
deg_ranks = centrality(G,'outdegree','Importance',G.Edges.Weight);
edges = linspace(min(deg_ranks),max(deg_ranks),15);
bins = discretize(deg_ranks,edges);
p.MarkerSize = bins;
title("Out Degree Node Importance for Forward Chem")
%}

