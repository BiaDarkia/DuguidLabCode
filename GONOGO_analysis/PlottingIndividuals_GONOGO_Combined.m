%% Intro
% This script generates a figure composed of several plots, one for each
% relevant variable (e.g. Hits, Misess... ). In each plot the overall
% session performance over several days is shown combined with the timed
% performance in each day.
%% Setting up
% Specify parameters to determine how the plots will look like

% Number of subplot in figure
% m n determine the grid of subplot
m = 5;
n = 2;

% Line thickness
Line_width = 0.75; % width lines of bars
Width_lines = 2; % width single lines

%% Generating axes
Mod2Start = find(DayMode(:,mouse_ID) == 2,1)-0.5;

if isempty(Mod2Start)
    Mod2Start = 0.5; % If we can't find a start day let's assume it's day one
end
Miss_max = max(max(Misses(:,mouse_ID)));
FA_max = max(max(Misses(:,mouse_ID)));

if Miss_max > FA_max
    Axis_miss = Miss_max;
else
    Axis_miss = FA_max;
end


%% Plotting
fig = figure;
set(gcf,'numbertitle','off','name',MouseName);
if num_days ~= lastNonOptoDay
    RectangleWidth = num_days - lastNonOptoDay;
else
    RectangleWidth = num_days;
end

%% Plotting

% Use "apparatusRecord" to mark the days in which the mouse was trained on
% the boxes (0) vs the lever rig ( 1)


% Plotting Hits
PlotterHisto (m,n,1, [0, 0, lastNonOptoDay-0.5+0.5, max(Hits(:,mouse_ID))],...
    Hit_timed, [0.2 0.2 0.7], [0.5 0.5 0.9], [0.8 0.8 1], Hits(:,mouse_ID), 'k', 'Hit', 'Training Days', 'Num',...
    Line_width, Width_lines, Mod2Start,lastNonOptoDay,[lastNonOptoDay, 0, lastNonOptoDay, max(Hits(:,mouse_ID))])

% Plotting Misses
PlotterHisto (m,n,3, [0, 0, lastNonOptoDay-0.5+0.5, max(Misses(:,mouse_ID))],...
    Miss_timed, [0.2 0.2 0.7], [0.5 0.5 0.9], [0.8 0.8 1], Misses(:,mouse_ID), 'k', 'Miss', 'Training Days', 'Num',...
    Line_width, Width_lines, Mod2Start,lastNonOptoDay, [lastNonOptoDay, 0, lastNonOptoDay, max(Misses(:,mouse_ID))])

% Plotting False Alarms
PlotterHisto (m,n,4, [0, 0, lastNonOptoDay-0.5+0.5, max(FalseAlarms(:,mouse_ID))],...
    FA_timed, [0.7 0.2 0.2], [0.9 0.5 0.5], [1 0.8 0.8], FalseAlarms(:,mouse_ID), 'k','False Alarm', 'Training Days', 'Num',...
    Line_width, Width_lines, Mod2Start,lastNonOptoDay, [lastNonOptoDay, 0,  lastNonOptoDay, max(FalseAlarms(:,mouse_ID))])

% Plotting Correct Rejections
PlotterHisto (m,n,2, [0, 0, lastNonOptoDay-0.5+0.5, max(CorrectRejections(:,mouse_ID))],...
    CR_timed, [0.7 0.2 0.2], [0.9 0.5 0.5], [1 0.8 0.8], CorrectRejections(:,mouse_ID), 'k','Correct Rejection', 'Training Days', 'Num',...
    Line_width, Width_lines, Mod2Start,lastNonOptoDay, [lastNonOptoDay, 0, lastNonOptoDay, max(CorrectRejections(:,mouse_ID))])

% Plotting Preemptives
if max(Preemptives_ITI(:,mouse_ID)) > 100
    MaxRect = max(Preemptives_ITI(:,mouse_ID));
else
    MaxRect = 100.5;
end

PlotterHisto (m,n,6, [0, 0, lastNonOptoDay-0.5+0.5, MaxRect],...
    PEI_timed, [0.2 0.7 0.2], [0.5 0.9 0.5], [0.8 1 0.8], Preemptives_ITI(:,mouse_ID), 'k','PE + Complete PE ratio', 'PEI', 'Num',...
    Line_width, Width_lines, Mod2Start,lastNonOptoDay, [lastNonOptoDay, 0,  lastNonOptoDay, max(MaxRect(:,mouse_ID))])

plot(CompletePEratio, '- k', 'LineWidth', 3); hold on,
plot(ones(1, lastNonOptoDay).*100, '-- k');


% Plotting Tone Efficiency
subplot(m,n,5); 
rectangle('Position', [0.5, 0, lastNonOptoDay-0.5,100], 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', [1 1 1]); hold on;
rectangle('Position', [lastNonOptoDay, 0,  RectangleWidth, 100], 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', [.6 .6 .6]);
plot(ToneEff_GO(:,mouse_ID), '- b o', 'LineWidth', Width_lines); hold on;
plot(ToneEff_NOGO(:,mouse_ID), '- r o', 'LineWidth', Width_lines);
plot(ToneEff_TOT, '- k o', 'LineWidth', Width_lines);
x = ones(1,length(ToneEff_NOGO))*75; plot(x, 'k --');
title('Tone Efficiency'); legend('GO', 'NOGO', 'TOT'); axis([Mod2Start lastNonOptoDay 0 100]);
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:lastNonOptoDay]); xlabel('Training Days'); ylabel('%'); hold off;

% Plotting Reaction Time
subplot(m,n,7);  
rectangle('Position', [0.5, 0, lastNonOptoDay-0.5, 4000], 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', [1 1 1]); hold on;
rectangle('Position', [lastNonOptoDay, 0,  RectangleWidth, 4000], 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', [.6 .6 .6]);
errorbar(Median_ReactTime_Hit(:, mouse_ID), Std_ReactTime_Hit(:, mouse_ID), '- b o', 'LineWidth', Width_lines);  hold on;
errorbar( Median_ReactTime_FalseAlarm(:, mouse_ID),Std_ReactTime_FalseAlarm(:, mouse_ID), '- r o', 'LineWidth', Width_lines);
xlabel(' Training days');  ylabel('mSec');
axis([Mod2Start, lastNonOptoDay, 0, 4000]);
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:lastNonOptoDay]);grid on;
title('Reaction Time'); legend('GO', 'NOGO','Location', 'NorthWest'); hold off;

% Plotting Discr. and Bias Index
subplot(m,n,8); 
rectangle('Position', [0.5, -1, lastNonOptoDay-0.5, 2], 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', [1 1 1]); hold on;
rectangle('Position', [lastNonOptoDay, -1,  RectangleWidth, 2], 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', [.6 .6 .6]);
plot(DiscrIndex, '- k o', 'LineWidth', Width_lines); hold on;
plot(B, '- m o', 'LineWidth', Width_lines);
X = zeros(1,length(DiscrIndex)); x = ones(1,length(ToneEff_NOGO))*0.5;
plot(X, '- k'); plot(x, 'k --'); plot(-x, 'k --'); 
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:lastNonOptoDay]); axis([Mod2Start, lastNonOptoDay, -1, 1 ]); 
legend('Discrimination index','Bias Index'); title('Discrimination Index');  xlabel('Training Days'); ylabel('-');hold off;


% Plotting Num. Trials between correct trial
subplot(m,n,9); 
rectangle('Position', [0, 0 lastNonOptoDay, max(Tr2Corr_avg)+max(Tr2Corr_sem)], 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', [1 1 1]); hold on;
rectangle('Position', [lastNonOptoDay, 0,  RectangleWidth, max(Tr2Corr_avg)+max(Tr2Corr_sem)], 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', [.6 .6 .6]);
errorbar(Tr2Corr_avg, Tr2Corr_sem, '- k o', 'LineWidth', Width_lines);
X = zeros(1,length(DiscrIndex)); plot(X, '- k');
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:lastNonOptoDay]); axis([Mod2Start, lastNonOptoDay, 0, inf ]); 
title('Num. trials to Correct Trial');  xlabel('Training Days'); ylabel('Num. Tr.'); hold off;


% Plotting Num. seconds between correct trial
subplot(m,n,10); 
rectangle('Position', [0, 0, lastNonOptoDay, max(Sec2Corr_avg)+max(Sec2Corr_sem)], 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', [1 1 1]); hold on;
rectangle('Position', [lastNonOptoDay, 0,  RectangleWidth, max(Sec2Corr_avg)+max(Sec2Corr_sem)], 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', [.6 .6 .6]);
errorbar(Sec2Corr_avg, Sec2Corr_sem, '- k o', 'LineWidth', Width_lines);
X = zeros(1,length(DiscrIndex)); plot(X, '- k');
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:lastNonOptoDay]); axis([Mod2Start, lastNonOptoDay, 0, inf ]); 
title('Seconds to Correct Trial');  xlabel('Training Days'); ylabel('Sec'); hold off;

