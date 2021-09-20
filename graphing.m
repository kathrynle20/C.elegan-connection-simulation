
clf(figure(1))
figure(1);
%x = [0 2 4 6 8 10 12 14 16 18 20];
original = avgDiff(1);
y = abs(original - avgDiff);
%y = [avg0-avg0 abs(avg2-avg0) abs(avg4-avg0) abs(avg6-avg0) abs(avg8-avg0) abs(avg10-avg0) abs(avg12-avg0) abs(avg14-avg0) abs(avg16-avg0) abs(avg18-avg0) abs(avg20-avg0)];
scatter(nChanged*2,y)
hold on
fig = line(nChanged*2,y)
xlim([0 25])
ylim([0 0.1])
xlabel('n-removed (number of neurons)')
ylabel('Difference')
title('Forward gap symmetry diff vs n-removed')

%{
clf(figure(2))
figure(2)
%out = abs(avg0-avg);
%out(abs(out)<0.005)=0;
fig2 = heatmap(out,'Colormap',jet,'ColorLimits',[0 1]);
grid off
ax = gca;
ax.XData = order;
ax.YData = order;
ax.FontSize = 7;
ylabel('Neurons'); xlabel('Neurons');
title('Backwards Chem Symmetry Diff 0 vs 20 changed');
%}
%{
clf(figure(3))
figure(3)
top10RemovedSize = size(top10Removed);
%making connectionsRemovedMatrix which is a matrix that mill have the
%frequency of the connections removed in the top 10
connectionsRemovedMatrix = zeros(matrixSize(1),matrixSize(2));
for rowTop10Removed=1:top10RemovedSize(1)
    r = top10Removed(rowTop10Removed,2);
    c = top10Removed(rowTop10Removed,3);
    connectionsRemovedMatrix(r,c) = connectionsRemovedMatrix(r,c) + 1;
    %connectionsRemovedMatrix(top10Removed(rowTop10Removed,2),top10Removed(rowTop10Removed,3)) = connectionsRemovedMatrix(top10Removed(rowTop10Removed,2),top10Removed(rowTop10Removed,3)) + 1;
end
out = connectionsRemovedMatrix;
fig3 = heatmap(out,'Colormap',jet,'ColorLimits',[0 10]);
grid off
ax = gca;
ax.XData = order;
ax.YData = order;
ax.FontSize = 7;
ylabel('Neurons'); xlabel('Neurons');
title('Mode Connections Removed in Top10');

%finding the frequency of mode value
M = max(connectionsRemovedMatrix);
frequencyMode = max(M)
%finding the indicies in connectionsRemovedMatrix with that frequency
[rowModeIndex,colModeIndex] = find(connectionsRemovedMatrix==frequencyMode);
%putting the row and column together in one matrix
modeIndex = [rowModeIndex colModeIndex]
rowModeIndexSize = size(rowModeIndex);
%for every connection with the same frequency, find the name of neurons in
%the connection by indexing order
modeConnections = [];
for modeIndexLoop=1:rowModeIndexSize(1)
    modeConnections = [modeConnections; order(rowModeIndex(modeIndexLoop)) order(colModeIndex(modeIndexLoop))];
end
modeConnections
%}
