function [newMatrix,changedElements] = removeRandConGap(matrix,num,Rstart,Rend,Cstart,Cend);
    %returns randomized matrix and the indices of changed elements in a
    %matrix

    % initiate random number generator
    rng(0,'twister');
    rng('shuffle');
    
    % array to keep track of elements already changed
    changed = [0,0];
    
    % amount of connections removed
    randRemoveCount = 0;

    %randAddCount
    while randRemoveCount < num
        % random row and column number to remove connection
        randRowR = randi([Rstart Rend],1,1);
        randColumnR = randi([Cstart Cend],1,1);
        
        % checks if the element is connected and if the element has already
        % been changed
        if matrix(randRowR,randColumnR) > 0
            
            if ~ismember([randRowR randColumnR],changed,'rows')
                %randRemoveCount
                matrix(randRowR,randColumnR) = 0;
                matrix(randColumnR,randRowR) = 0;
            
                % adds element index to array of changed elements
                changed = [changed ; randRowR randColumnR];
                changed = [changed ; randColumnR randRowR];
            
                % increment connections added
                randRemoveCount = randRemoveCount + 1;
            end
        end
    end
    %disp('Bye')
    newMatrix = matrix;
    changedElements = changed;
    
    
end

