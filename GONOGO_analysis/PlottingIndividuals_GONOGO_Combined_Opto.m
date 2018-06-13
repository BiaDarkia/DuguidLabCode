%% Intro
% Similar to PlottingIndividuals_Combined but  for opto
% stim and no stim trials
%% Setting up
% Specify parameters to determine how the plots will look like

% Number of subplot in figure
% m n determine the grid of subplot
m = 4;
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

FirstOptoDay = find(optoRecord,1) - 0.5; 
numOptoDays = length(optoRecord) - FirstOptoDay + 1.5; 

%% Get num of stim vs no stim trials
num_NoStimTrials = Num_trials(lastNonOptoDay+1:end)' - num_OptoStimtrials; 

%% Plotting Opto Stim Trials 
fig = figure;
titlestring = sprintf([MouseName, '  Opto Stim - No Stim']);
set(gcf,'numbertitle','off','name',titlestring);

subplotwidth = .425; 
subplotheight = .075; 

% subplot('Position', [0.0135, 0.105, 0.058, 0.822]); 
% plot([2,2],[0, numOptoDays], 'k', 'LineWidth', 2); hold on
% plot([0.5, 3.5], [numOptoDays, numOptoDays], 'k', 'LineWidth', 2);
% text(0.25, numOptoDays+1, 'Num Opto Stim Trials'); 
% text(3.25, numOptoDays+1, 'Num No Stim Trials'); 
% axis([0, 4, 0, numOptoDays+1]); 


% Plotting Hits
ax1 = subplot(m,n,1); 
if max(Hit_OptoStim(mouse_ID, :)) >= max(Hit_NoStim(mouse_ID, :))
    maxRect = max(Hit_OptoStim(mouse_ID, :)); 
else
    maxRect = max(Hit_NoStim(mouse_ID, :)); 
end
PlotterHist_TwoVariables( [0, 0, numOptoDays-0.5+0.5, maxRect],...
    Hit_OptoStim_timed, Hit_NoStim_timed, [0.2 0.2 0.7], [0.5 0.5 0.9], [0.8 0.8 1],...
    'Hits', 'Opto Days', 'Num', Line_width, 0, numOptoDays)

for i = 1:numOptoDays-1
    text(i-0.2,  2, num2str(num_OptoStimtrials(i)), 'Color', [.9 .9 .9], 'FontSize', 16); 
    text(i+0.06,  2, num2str(num_NoStimTrials(i)),  'Color', [.9 .9 .9], 'FontSize', 16); 
end

% Plotting False Alarms
ax2 = subplot(m,n,2); 
if max(FalseAlarm_NoStim(mouse_ID, :)) >= max(FalseAlarm_OptoStim(mouse_ID, :))
    maxRect = max(FalseAlarm_NoStim(mouse_ID, :)); 
else
    maxRect = max(FalseAlarm_OptoStim(mouse_ID, :)); 
end
PlotterHist_TwoVariables( [0, 0, numOptoDays-0.5+0.5, maxRect],...
    FA_OptoStim_timed, FA_NoStim_timed, [0.7 0.2 0.2], [0.9 0.5 0.5], [1 0.8 0.8],...
    'False Alarms', 'Opto Days', 'Num', Line_width, 0, numOptoDays)

% Plotting Misses
ax3 = subplot(m,n,3); 
if max(Miss_OptoStim(mouse_ID, :)) >= max(Miss_NoStim(mouse_ID, :))
    maxRect = max(Miss_OptoStim(mouse_ID, :)); 
else
    maxRect = max(Miss_NoStim(mouse_ID, :)); 
end
PlotterHist_TwoVariables( [0, 0, numOptoDays-0.5+0.5, maxRect],...
    Miss_OptoStim_timed, Miss_NoStim_timed, [0.2 0.2 0.7], [0.5 0.5 0.9], [0.8 0.8 1],...
    'Misses', 'Opto Days', 'Num', Line_width, 0, numOptoDays)

% Plotting Correct Rejections
ax4 = subplot(m,n,4); 
if max(CorrectRejection_OptoStim(mouse_ID, :)) >= max(CorrectRejection_NoStim(mouse_ID, :))
    maxRect = max(CorrectRejection_OptoStim(mouse_ID, :)); 
else
    maxRect = max(CorrectRejection_NoStim(mouse_ID, :)); 
end
PlotterHist_TwoVariables( [0, 0, numOptoDays-0.5+0.5, maxRect],...
    CR_OptoStim_timed, CR_NoStim_timed, [0.7 0.2 0.2], [0.9 0.5 0.5], [1 0.8 0.8],...
    'Correct Rejections', 'Opto Days', 'Num', Line_width, 0, numOptoDays)


% Plotting Preemptives
ax5 = subplot(m,n,6);
if max(Preemptives_ITI_OptoStim(mouse_ID, :)) >= max(Preemptives_ITI_NoStim(mouse_ID, :))
    maxRect = max(Preemptives_ITI_OptoStim(mouse_ID, :)); 
else
    maxRect = max(Preemptives_ITI_NoStim(mouse_ID, :)); 
end
PlotterHist_TwoVariables( [0, 0, numOptoDays-0.5+0.5, maxRect],...
    PEI_OptoStim_timed, PEI_NoStim_timed, [0.2 0.7 0.2], [0.5 0.9 0.5], [0.8 1 0.8],...
    'Preemptives', 'Opto Days', 'Num', Line_width, 0, numOptoDays)


% Plotting Tone Efficiency
ax6 = subplot(m,n,5);
PlotterTwoLines_opto(1, 1,[0, 0, numOptoDays,100], tone_eff_GO_OptoStim(mouse_ID, :), tone_eff_GO_NoStim(mouse_ID, :), ...
    [.2 .2 .8],' Opto Days', '%', 'Tone Efficiency', 0, numOptoDays,Line_width ); hold on; 
PlotterTwoLines_opto(0, 1,[0, 0, numOptoDays,100], tone_eff_NOGO_OptoStim(mouse_ID, :), tone_eff_NOGO_NoStim(mouse_ID, :), ...
    [.8 .2 .2],' Opto Days', '%', 'Tone Efficiency', 0, numOptoDays,Line_width);
PlotterTwoLines_opto(0, 1,[0, 0, numOptoDays,100], tone_eff_tot_OptoStim(mouse_ID, :), tone_eff_tot_NoStim(mouse_ID, :), ...
    [.2 .2 .2],' Opto Days', '%', 'Tone Efficiency', 0, numOptoDays,Line_width);
axis([0 numOptoDays 0 100]);


% Plotting Reaction Time
ax7 = subplot(m,n,7); 
PlotterTwoLines_opto(1, 2, [0, 0, numOptoDays,4000], median_reaction_time_Hit_OptoStim(mouse_ID ,:), median_reaction_time_Hit_NoStim(mouse_ID ,:), ...
    [.2 .2 .8],' Opto Days', 'mS', 'Reaction Time', 0, numOptoDays,Line_width, ...
    std_reaction_time_Hit_OptoStim(mouse_ID ,:), std_reaction_time_Hit_NoStim(mouse_ID ,:), 0.025); hold on; 

PlotterTwoLines_opto(0, 2, [0, 0, numOptoDays,4000], median_reaction_time_FalseAlarm_OptoStim(mouse_ID ,:), median_reaction_time_FalseAlarm_NoStim(mouse_ID ,:), ...
    [.8 .2 .2],' Opto Days', 'mS', 'Reaction Time', 0, numOptoDays,Line_width,...
    std_reaction_time_FalseAlarm_OptoStim(mouse_ID ,:), std_reaction_time_FalseAlarm_NoStim(mouse_ID ,:), 0); hold on; 
axis([0, numOptoDays, 0, 4000]);


% Plotting Discr. and Bias Index
ax8 = subplot(m,n,8); 
PlotterTwoLines_opto(1, 1,[0,-1, numOptoDays,2], ...
    DiscrIndex_OptoStim(mouse_ID ,:), DiscrIndex_NoStim(mouse_ID, :), ...
    [.2 .2 .2],' Opto Days', 'arbr. unit.', 'Discr. Indx. - Bias Indx.', 0, numOptoDays,Line_width ); hold on; 
PlotterTwoLines_opto(0, 1,[0, -1, numOptoDays,2], ...
    B_OptoStim(mouse_ID ,:), B_NoStim(mouse_ID, :), ...
    [.7 .2 .7],' Opto Days', 'arbr. unit.', 'Discr. Indx. - Bias Indx.', 0, numOptoDays,Line_width );
X = zeros(1,numOptoDays+1); x = ones(1,numOptoDays+1)*0.5;
plot([0:numOptoDays], X, '- k'); plot([0:numOptoDays], x, 'k --'); plot([0:numOptoDays], -x, 'k --');
axis([0, numOptoDays, -1, 1 ]); 

% 
% % Plotting Num. Trials between correct trial
% ax9 = subplot(m,n,9); 
% PlotterTwoLines_opto(1, 2, [0, 0, numOptoDays, max(AvgNumTrials_OptoStim(mouse_ID ,:)) + max(SemNumTrials_OptoStim(mouse_ID ,:))],...
%     AvgNumTrials_OptoStim(mouse_ID ,:), AvgNumTrials_NoStim(mouse_ID ,:), ...
%     [.2 .2 .2],' Training Days', 'num', 'Num trials to correct to next correct', 0, numOptoDays,Line_width, ...
%     SemNumTrials_OptoStim(mouse_ID ,:), SemNumTrials_NoStim(mouse_ID ,:), 0); hold on; 
% 
% % Plotting Num. seconds between correct trial
% ax10 = subplot(m,n,10); 
% PlotterTwoLines_opto(0, 2, [0, 0, numOptoDays,max(AvgTimeTrials_OptoStim(mouse_ID ,:)) + max(SemTimeTrials_OptoStim(mouse_ID ,:))],...
%     AvgTimeTrials_OptoStim(mouse_ID ,:), AvgTimeTrials_NoStim(mouse_ID ,:), ...
%     [.2 .2 .2],' Training Days', 'num', 'Num seconds to correct to next correct', 0, numOptoDays,Line_width, ...
%     SemTimeTrials_OptoStim(mouse_ID ,:), SemTimeTrials_NoStim(mouse_ID ,:), 0); hold on; 

