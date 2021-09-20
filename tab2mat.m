T = readtable("Forward Gap Hernans Symmetry.tsv",'FileType',"text");
%T = readtable ("Backwards Gap Hernans Symmetry.tsv",'FileType',"text");
%T = readtable ("Backwards Chemical Hernans symmetry.tsv",'FileType',"text");
%T = readtable("Forward Chemical Hernans Symmetry.tsv","FileType","text");
G = digraph(table2array(T(:,1)),table2array(T(:,2)),table2array(T(:,3)));
A = full(adjacency(G,"weighted"));
Forward_gap_order = {'DB05';'DB06';'DB07';'VB10';'VB11';'DB04';'VB02';'DB01';'VB04';'DB03';'VB05';'DB02';'VB01';'VB06';'VB07';'VB03';'VB08';'VB09';'RIBL';'RIBR';'AVBL';'AVBR'};
Backward_gap_order = {'VA02';'VA03';'VA06';'VA07';'VA08';'VA09';'VA10';'VA11';'VA12';'DA03';'DA06';'DA07';'DA05';'DA09';'DA08';'DA04';'DA01';'VA01';'DA02';'VA04';'VA05';'RIML';'RIMR';'AIBL';'AIBR';'AVEL';'AVER';'AVAL';'AVAR'};
Forward_chem_order = {'VB03';'VB04';'VB05';'VB10';'VB11';'DB07';'DB06';'DB03';'DB04';'DB02';'VB06';'VB07';'VB08';'VB09';'AVBL';'AVBR';'RIBR';'RIBL';'PVCL';'PVCR'};
Backward_chem_order = {'DA05';'DA08';'DA09';'VA06';'VA11';'VA12';'VA10';'DA07';'DA06';'DA01';'DA02';'DA03';'DA04';'VA02';'VA03';'VA04';'VA05';'VA01';'VA08';'VA09';'AVEL';'AVER';'AVAL';'AVAR';'AVDL';'AVDR';'AIBL';'AIBR';'RIML';'RIMR'};
order = Forward_gap_order;
tbl = array2table(A,"RowNames",table2array(G.Nodes),"VariableNames",table2array(G.Nodes));
A = table2array(tbl(order,order));
tic