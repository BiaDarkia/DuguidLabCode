%% This scripts plots Hit Ratio vs False Alarms Ratio for each daily session for 1 mouse

% Plots the timed analysis of the hit rate, false alarm rate and
% discrimination index rate using a sliding window avarage. 


% This function generates a figure for each of the mice being plotted.
% IN this figure each training session is represented as an individual
% subplot. In each subplot the points indicate the ratio beween hit
% rate (Y axis) and false alarm rate (X axis). The label of each data
% point represents the discrimination index value for at that time.


%% Calculate stuff
% Clear up variables (Got them from main plotting script --> Getting
% VarPlottingGONOGO)
Hit_times(Hit_times == 0) = NaN;
Miss_times(Miss_times == 0) = NaN;
FA_times(FA_times == 0) = NaN;
CR_times(CR_times == 0) = NaN;

% ################################
% ################################
% Sliding window - set up      <--- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Wnd = 600000; % Length of the window
StepNum = 100; 
Step = Wnd/StepNum; % step wise sliding 
WndNum = 1; %flag for how many steps, needed to save variables correctly
% ################################
% ################################


% clear used variables if necessary
try 
    clear HW; clear MW; clear FW; clear CW; 
catch
    a = 1; % need to put something here 
end

MinMarks = 0; % FLAG


%% Use the window to calculate 
Mod2Start = find(DayMode(:,mouse_ID) == 2,1); %-0.5;
if isempty(Mod2Start)
    Mod2Start = 1; % If we can't find a start day let's assume it's day one
end

for i = Mod2Start:size(Hit_times, 2)
    % Create place holder variables for each day (easier to handle)
    HT = Hit_times(:,i);
    MT = Miss_times(:,i);
    FT = FA_times(:,i);
    CT = CR_times(:,i);
    WndNum = 1; % flag to count number of windows
    
    % Window the Hit, Misses, False alarms and Correct Rejections
    for ii = 1:Step:(TrainingLength(i)*1000)+1-(Wnd/6)
        try % Hits Windowed
            HW(WndNum,i) = length(HT(HT > ii & HT < (ii+Wnd-1) )); % See if there's any within the window
        catch 
            HW(WndNum,i) = 0 ;          % Otherwise = 0
        end
        
        try % Misses Windowed
            MW(WndNum,i) = length(MT(MT > ii & MT < (ii+Wnd-1) ));
        catch 
            MW(WndNum,i) = 0 ;
        end
        
        try % False Alamrs Windowed
            FW(WndNum,i) = length(FT(FT > ii & FT < (ii+Wnd-1) ));
        catch 
            FW(WndNum,i) = 0 ;
        end
        
        try % Correct Rejections Windowed
            CW(WndNum,i) = length(CT(CT > ii & CT < (ii+Wnd-1) ));
        catch
            CW(WndNum,i) = 0 ;
        end
        
        % Get time at this step:find wnds at 10,20... mins
        PassedTime(WndNum) = round(ii*(1e-03)); % Passed time in seconds
        if  PassedTime(WndNum) == TrainingLength(i)/8 || PassedTime(WndNum) == (TrainingLength(i)/8)*2 ...
                || PassedTime(WndNum) == (TrainingLength(i)/8)*3 || PassedTime(WndNum) == (TrainingLength(i)/8)*4 ...
                || PassedTime(WndNum) == (TrainingLength(i)/8)*5 || PassedTime(WndNum) == (TrainingLength(i)/8)*5 ...
                || PassedTime(WndNum) == (TrainingLength(i)/8)*7 || PassedTime(WndNum) == (TrainingLength(i)/8)*8 ...
                
            if MinMarks == 0
                MinMarks = WndNum;
            else
                MinMarks = [MinMarks WndNum];
            end
        end
        
        WndNum = WndNum + 1; %update the counter
        
    end

    % Hit and False alarm rate windowed - Confine between 0.99 and 0.01
    HRW = HW ./ (HW + MW); %Hit rate windowed  --- (HW + MW = number of GO tones in each window)
    FRW = FW ./ (FW + CW); % False alarm windowed --- (FW + CW = number of NOGO tones in each window)
    
    HRW(isnan(HRW)) = 0.0001; HRW(HRW == 1) = 0.999; % need to eliminate the extremes
    FRW(isnan(FRW)) = 0.0001; FRW(FRW == 1) = 0.999;
    
    % Discr. Index windowed 
    DIW = (HRW - FRW);     
end
    

%% Create plots
FigTitle = ['DI - ', MouseName];

fig = figure;
set(gcf,'numbertitle','off','name',FigTitle)

% Calc num of subplot
DaysToPlot = num_days - (Mod2Start - 0.5) + 1;
n = 5; % Columns of subplots
m = roundn(DaysToPlot/n,0); % Num of rows of subplots

if m*n < DaysToPlot
    m = m+1; 
end

% Plot inidvidual session + summary in the end
for i = (Mod2Start):lastNonOptoDay+ 1;
    if i < (lastNonOptoDay+ 1)
        
        subplot(m,n,i); % Subplot index

        % Set up stuff for graphical objects
        titles = ['Session ' num2str(i)];
        dxx = [0,1];
        dyy = [0,1];
        a = [0.5 0.5];
        d = [0.5, 1];
        c = [0, 0.5];
        vertices = [0 0.5; 0.5 0.5; 0.5 1; 0 1];
        v2 = [0 0; 1 0; 1 1];
        v3 = [0 0; 0.5 0.5; 0 0.5];
        v4 = [0.5 0.5; 1 1; 0.5 1];
        v5 = [0.55 0.02;  1 0.02; 1 0.3; 0.55 0.3 ];

        % Plots shapes and lines for easy reading of the plot
        patch(vertices(1:end,1), vertices(1:end,2), [0.2 0.7 0.2], 'EdgeAlpha',0, 'FaceAlpha', 0.2); hold on;
        patch('Vertices', v2, 'FaceColor', 'k', 'EdgeAlpha',0, 'FaceAlpha', 0.2);
        patch('Vertices', v3, 'FaceColor', 'blue', 'EdgeAlpha',0, 'FaceAlpha', 0.2);
        patch('Vertices', v4, 'FaceColor', 'red', 'EdgeAlpha',0, 'FaceAlpha', 0.2);
        plot(dxx, dyy, '-- k', 'LineWidth', 1.5);
        plot(a,d, '-- k', 'LineWidth', 1.5);
        plot(c,a, ' -- k', 'LineWidth', 1.5);
        
        % !!!! Scatter plot of timed False Alarm and Hit rate !!! <----
        c = linspace(0,1,length(FRW(:,i))); sz = 100;
        scatter(FRW(:,i), HRW(:,i),sz,c,'filled');
        colormap(gray);
        
        % Calculate angles between points of scatter plot
        for a = 2:size(FRW(:,i),1)
            % coords of 2 consecutive points in plot + a horizzonatal
            % vectore
            x1 = FRW(a,i);
            x2 = FRW(a-1,i);
            x3 = 1;
            x4 = -1;
            
            y1 = HRW(a,i);
            y2 = HRW(a-1,i);
            y3 = HRW(a-1,i);
            y4 = HRW(a-1,i);

            % distance between the two points: if too small skip
            DistVec = [x1,y1; x2,y2];
            d = pdist(DistVec, 'euclidean');
            
            if d < 0.05
                ang(a) = nan;
            else % Calc angle and add to variable
                angle_in_deg=atan2(y2-y1,x2-x1)*180/pi;
                ang(a) = angle_in_deg;
                
            end
        end
        
        % Find max discrimination index
        MaxDIW(i) = max(DIW(:,i));
        index = find(DIW(:,i) == MaxDIW(i),1);

        
        % Get the time in s of max DI
        IndRatio = index/WndNum;
        TimeLength = TrainingLength(i);
        TimeMaxDI(i) = IndRatio*TimeLength;
        
        % Get the number of rewards up to that point
        if ~isnan(find(~isnan(Hit_times(:,i)),1,'first'))
            try
                RewMaxDI(i) = (find(Hit_times(:,i) > TimeMaxDI(i)*1000, 1)-1)*2;  % *2 because of symmetric training
            catch % If there is no reward after the TimeMaxDI it means that all the rewards happened before that point
                RewMaxDI(i) = find(~isnan(Hit_times(:,i)), 1, 'last')*2;  % RewMaxDI = total number of rewards - *2 because of sym training
            end
        else
            RewMaxDI(i) = 0;
        end
        
        % Plot max DI, time and rewards
        plot(FRW(index,i), HRW(index,i), 'r *', 'LineWidth', 3); % red dot over the place of scatter plot it corresponds to
        patch(v5(1:end,1), v5(1:end,2), [1 1 1], 'EdgeAlpha',0, 'FaceAlpha', 0.7); hold on; % to highlight the text
        text(0.55,0.05, ['Max DI  ', num2str(round(MaxDIW(i),1))]);
        text(0.55,0.15, ['Rew Max DI  ', num2str(round(RewMaxDI(i),2))]);
        text(0.55,0.25, ['Time Max DI  ', num2str(round(TimeMaxDI(i)/60,2))]); % /60 to give it in minutes  
        
        % manipualte figure axis
        axis([0, 1, 0, 1]);
        xlabel('False Alarm rate'), ylabel('Hit Rate'); title(titles);
        set(gca,'XTickMode','manual'); set(gca,'XTick',[0:0.5:1]);
        set(gca,'YTickMode','manual'); set(gca,'YTick',[0:0.5:1]);
        
        % Plot minute marks
        plot(FRW(MinMarks,i), HRW(MinMarks,i), 'b o', 'LineWidth', 1); % red dot over the place of scatter plot it corresponds to
        
        
        hold off;
    else % Plot max DI and assocaited stuff over training sessions in the last subplot
        subplot(m,n,i);
        
        % Set up stuff
        xx = [Mod2Start+0.5, num_days]; 
        yy = [0, 0];
        yy2 = [0.5, 0.5];
        yy3 = [-0.5, -0.5];
        yy4 = [0.75, 0.75];
        
        % Plotting
        plot(MaxDIW*100, '- g o', 'LineWidth', 2); hold on;  % times 100 to improve interpretation of graph
        plot(RewMaxDI, ' - r o', 'LineWidth', 2); 
        plot(TimeMaxDI./60, ' - b o', 'LineWidth', 2); % in minutes
        plot(xx,yy, ' - k', 'LineWidth', 0.3);
        plot(xx,yy2.*100, ' -- k', 'LineWidth', 0.2);
        
        % Axis
        legend('DImax', 'Rew DI max', 'Time DI max', 'Location', 'SouthEast');
        title('Max discr. index');
        axis([Mod2Start+0.5, num_days, -25, 100])
%         set(gca,'XTickMode','manual'); set(gca,'XTick',[0:2:num_days]);
%         set(gca,'YTickMode','manual'); set(gca,'YTick',[-1:0.5:1]);
%         

        
    end
end

%% Conclusion
% Add Max. Discr. Index. to all_var
all_var.MaxDiscrIndx = MaxDIW;
save(filename, 'all_var');

% discard varibales
clear MaxDIW; clear RewMaxDI; clear TimeMaxDI;

 



