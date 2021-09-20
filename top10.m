%originalFile = matfile('back_chem_original_avgD.mat');
%originalFile = matfile('for_chem_original_avgD.mat');
originalFile = matfile('back_gap_origin_avgD.mat');
%originalFile = matfile('for_gap_original_avgD.mat');
%for back chem and gap and for gap
original = originalFile.avgD0;
%for for chem
%original = originalFile.avgD;
%original = avgD0;
%activityList = abs(activityList - original);
%index = [1:100]';
%activityList = [index activityList];

differences = [];
top10Values = [];
for i = 1:100
    differences = [differences;i abs(avgList(i,:) - original)];
end

avgThreshold = sum(differences(:,2), 'all')/100;


for j = 1:10
    [value,index] = max(differences(:,2));
    top10Values = [top10Values; differences(index,1) value];
    differences(index,:) = [];
end

top10Removed = [];

for k = 1:10
    %get all changed values from changed using the index in top10Values and
    %multiplication and disregard the first row of 0,0. Make another matrix
    %to store the values and index from changed. use k to go down the list
    %of top values.
    removedIndex = top10Values(k,1);
    %top10Removed = [top10Removed;removed(((removedIndex-1)*(change + 1))+2:removedIndex*(change + 1),:)];
    top10Removed = [top10Removed;removed(((removedIndex-1)*(change * 2 + 1))+2:removedIndex*(change * 2 + 1),:)];
end

%{
[rowMode, rowFrequency] = mode(top10Removed(:,2))
[colMode, colFrequency] = mode(top10Removed(:,3))
rowNameMode = order(rowMode)
colNameMode = order(colMode)
%}
