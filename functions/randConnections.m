function [newMatrix,changedElements] = randConnections(matrix,numAdd,numRemove,R,C);
    %returns randomized matrix and the indices of changed elements in a matrix
    
    % get size of the matrix for range of random numbers
    sz = size(matrix);
    row = sz(1);
    column = sz(2);
    
    avg1 = mean(nonzeros(matrix(1:R, 1:C)));
    avg2 = mean(nonzeros(matrix(1:R , C+1:column)));
    avg3 = mean(nonzeros(matrix(R+1:row , 1:C)));
    avg4 = mean(nonzeros(matrix(R+1:row , C+1:column)));
    
    std1 = std(nonzeros(matrix(1:R, 1:C)));
    std2 = std(nonzeros(matrix(1:R , C+1:column)));
    std3 = std(nonzeros(matrix(R+1:row , 1:C)));
    std4 = std(nonzeros(matrix(R+1:row , C+1:column)));

    % initiate random number generator
    rng(0,'twister');
    rng('shuffle');
    
    % array to keep track of elements already changed
    changed = [0,0];
    
    % amount of connections added and removed
    randAddCount = 0;
    randRemoveCount = 0;
    
    % determine what category chosen element is
    % 1 = ee, 2 = ei, 3 = ie, 4 = ii
    type = 0;
    
    % Adding random connections
    while (randAddCount < numAdd)
        % random row and column number to add connection
        randRowA = randi([1 row],1,1);
        randColumnA = randi([1 column],1,1);
        
        % determine section of matrix random element is
        if ismember(randRowA,1:R)
            if ismember(randColumnA,1:C)
                type = 1;
            else
                type = 2;
            end
        elseif ismember(randRowA,R+1:row)
            if ismember(randColumnA,C+1:column)
                type = 4;
            else
                type = 3;
            end
        end
        
        % checks if the element is not connected and if the element has 
        % already been changed
        if matrix(randRowA,randColumnA) == 0
            if ~ismember([randRowA randColumnA],changed,'rows')
                randWeight = 1;
                if type == 1
                    untruncated = makedist('Normal',avg1,std1);
                    truncated = truncate(untruncated,0.5,inf);
                    randWeight = round(random(truncated,1,1));
                elseif type == 2
                    untruncated = makedist('Normal',avg2,std2);
                    truncated = truncate(untruncated,0.5,inf);
                    randWeight = round(random(truncated,1,1));
                elseif type == 3
                    untruncated = makedist('Normal',avg3,std3);
                    truncated = truncate(untruncated,0.5,inf);
                    randWeight = round(random(truncated,1,1));
                elseif type == 4
                    untruncated = makedist('Normal',avg4,std4);
                    truncated = truncate(untruncated,0.5,inf);
                    randWeight = round(random(truncated,1,1));
                end
                matrix(randRowA,randColumnA) = randWeight;
                
                % adds element index to array of changed elements
                changed = [changed ; randRowA randColumnA];
                
                % increment connections added
                randAddCount = randAddCount + 1;
            end
        end
        
    end
    %randAddCount
    while randRemoveCount < numRemove
        % random row and column number to remove connection
        randRowR = randi([1 row],1,1);
        randColumnR = randi([1 column],1,1);
        
        % checks if the element is connected and if the element has already
        % been changed
        if matrix(randRowR,randColumnR) > 0
            
            if ~ismember([randRowR randColumnR],changed,'rows')
                %randRemoveCount
                matrix(randRowR,randColumnR) = 0;
            
                % adds element index to array of changed elements
                changed = [changed ; randRowR randColumnR];
            
                % increment connections added
                randRemoveCount = randRemoveCount + 1;
            end
        end
    end
    %disp('Bye')
    newMatrix = matrix;
    changedElements = changed;
    
    
end

