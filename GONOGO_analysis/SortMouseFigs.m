function  SortMouseFigs( Mousenum, NumFigs, Screen )

% This function sorts all the figures of each mouse generated as part of
% the Plot GoNoGo functions. 

% it allows the user to plot figures on the main or external screen. 

% as imput it needs the mouse number, the number of figures per mouse and
% the selected screen ('Main'/'Ext'). Number of figures is shown in the command
% window when running the plotting function. 

%% Working with more than 1 figure per mouse
if NumFigs > 1
    %% Setting up variables
    ListFigsNum = [1+((Mousenum-1)*NumFigs):NumFigs*Mousenum]; % creates a vector with the handles of figures to be sorted
    
    Rows = 2;
    Cols = round(NumFigs/Rows);
    
    if NumFigs == 3
        Offset = [0,2];
    elseif NumFigs == 4
        Offset = [0,1,4,5];
    elseif NumFigs == 5
        Offset = [0,1,4,5];
    elseif NumFigs == 2
        Offset = [1]; 
    end
    
    %% Sorting figures
    %distFig('Screen', Screen, 'Only', ListFigsNum); % move all relevant figures to new screen
    
    distFig('Screen', Screen, 'Only', ListFigsNum(1), 'Rows', 1, 'Cols', 3, 'Offset', 1, 'Menu', 'none','Tight', 0); % main figure in the centre, spanat full height
    
    for i = 2:NumFigs
        
        distFig('Screen', Screen, 'Only', ListFigsNum(i), 'Rows', Rows, 'Cols', Cols, 'Offset', Offset(i-1), 'Menu', 'none','Tight', 0);
        
    end
else
%% Working with 1 figure per mouse 
    % finding number of figures open (= number of mice)

         fh=findobj(0,'type','figure');
   nf=size(fh,1); % maximal integer value is number of figures
    
    % Checking for external screen
    if strcmp(Screen, 'Ext') == 1 
        ScreenCheck = 1; 
    else
        ScreenCheck = 0; 
    end
    
    %number of columns 
    Rows = 1; 
    Cols = round(nf/2);  
    

    % Sorting them 
    for i = 1:nf
        if ScreenCheck == 1 && i>round(nf/2)
            Screen = 'Ext'; 
        else 
            Screen = 'Main'; 
        end
        
        distFig('Screen', Screen, 'Only', i, 'Rows', Rows, 'Cols', Cols, 'Offset', i-1, 'Menu', 'none','Tight', 0);
        
        
    end 
        
    
    
end

end

