function [newMatrix,changedElements] = restrictedRandCon(matrix,num,Rstart,Rend,Cstart,Cend);
    %returns randomized matrix and the indices of changed elements in a matrix
    
    % get range of random numbers
    row = Rend - Rstart;
    column = Cend - Cstart;

    % initiate random number generator
    rng(0,'twister');
    rng('shuffle');
    
    % array to keep track of elements already changed
    changed = [0,0];
    
    % amount of connections added and removed
    randAddCount = 0;
    randRemoveCount = 0;
    
    % Adding random connections
    while (randAddCount < num)
        % random row and column number to add connection
        randRowA = randi([Rstart Rend],1,1);
        randColumnA = randi([Cstart Cend],1,1);
        
        % checks if the element is not connected and if the element has 
        % already been changed
        if matrix(randRowA,randColumnA) == 0
            if ~ismember([randRowA randColumnA],changed,'rows')
                randWeight = 1;
                matrix(randRowA,randColumnA) = randWeight;
                
                % adds element index to array of changed elements
                changed = [changed ; randRowA randColumnA];
                
                % increment connections added
                randAddCount = randAddCount + 1;
            end
        end
        
    end
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

