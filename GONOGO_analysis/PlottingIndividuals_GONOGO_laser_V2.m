%% intro
% Create 3 figures to plot the data for a single mouse from both the
% training days and the opto stim days


%% Set up
% Specify parameters to determine how the plots will look like

% Number of subplot in figure
% m n determine the grid of subplot
m = 3;
n = 2;

% Line thickness
Line_width = 0.75; % width lines of bars
Width_lines = 2; % width single lines

% Generating axes
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

% Get num of stim vs no stim trials
num_NoStimTrials = Num_trials(lastNonOptoDay+1:end)' - num_OptoStimtrials; 

%% first figure --> quantitative vars
fig = figure;
titlestring = sprintf([MouseName, '  Opto Stim - No Stim']);
set(gcf,'numbertitle','off','name',titlestring);

subplotwidth = .7; 
subplotheight = .075; 

% Note where to plot opto data nd get number of opto stim and no stim
% trials
x0 = linspace(0, firstOptoDay, firstOptoDay+1);
x = linspace(firstOptoDay, num_days, num_days-firstOptoDay+1);
num_optostim_trials = Hit_OptoStim + Miss_OptoStim;
num_nostim_trials = Hit_NoStim + Miss_NoStim;

% Plotting Hits
ax1 = subplot(m,n,1); 
if max(Hit_OptoStim(mouse_ID, :)) >= max(Hit_NoStim(mouse_ID, :))
    maxRect = max(Hit_OptoStim(mouse_ID, :)); 
else
    maxRect = max(Hit_NoStim(mouse_ID, :)); 
end
plotting_onevar_laser(Hits, Hit_OptoStim, Hit_NoStim, x, 'b', firstOptoDay, ...
        num_optostim_trials, num_nostim_trials, 'Hits', num_days)


% Plotting False Alarms
ax2 = subplot(m,n,3); 
if max(FalseAlarm_NoStim(mouse_ID, :)) >= max(FalseAlarm_OptoStim(mouse_ID, :))
    maxRect = max(FalseAlarm_NoStim(mouse_ID, :)); 
else
    maxRect = max(FalseAlarm_OptoStim(mouse_ID, :)); 
end
plotting_onevar_laser(FalseAlarms, FalseAlarm_OptoStim, FalseAlarm_NoStim, x, 'r', firstOptoDay, ...
        num_optostim_trials, num_nostim_trials, 'False Alarms', num_days)

% Plotting Misses
ax3 = subplot(m,n,4); 
if max(Miss_OptoStim(mouse_ID, :)) >= max(Miss_NoStim(mouse_ID, :))
    maxRect = max(Miss_OptoStim(mouse_ID, :)); 
else
    maxRect = max(Miss_NoStim(mouse_ID, :)); 
end
plotting_onevar_laser(Misses, Miss_OptoStim, Miss_NoStim, x, 'b', firstOptoDay, ...
        num_optostim_trials, num_nostim_trials, 'Misses', num_days)

% Plotting Correct Rejections
ax4 = subplot(m,n,2); 
if max(CorrectRejection_OptoStim(mouse_ID, :)) >= max(CorrectRejection_NoStim(mouse_ID, :))
    maxRect = max(CorrectRejection_OptoStim(mouse_ID, :)); 
else
    maxRect = max(CorrectRejection_NoStim(mouse_ID, :)); 
end
plotting_onevar_laser(CorrectRejections, CorrectRejection_OptoStim, CorrectRejection_NoStim, x, 'r', firstOptoDay, ...
        num_optostim_trials, num_nostim_trials, 'Correct Rejection', num_days)

% Plotting Preemptives
ax5 = subplot(m,n,5);
if max(Preemptives_ITI_OptoStim(mouse_ID, :)) >= max(Preemptives_ITI_NoStim(mouse_ID, :))
    maxRect = max(Preemptives_ITI_OptoStim(mouse_ID, :)); 
else
    maxRect = max(Preemptives_ITI_NoStim(mouse_ID, :)); 
end
plotting_onevar_laser(Preemptives_ITI, Preemptives_ITI_OptoStim(mouse_ID, :), Preemptives_ITI_NoStim(mouse_ID, :), x, 'g', firstOptoDay, ...
        num_optostim_trials, num_nostim_trials, 'Preemptives', num_days)


% Plotting Reaction Time
ax6 = subplot(m,n,6);
plot(Median_ReactTime_Hit, '-ob', 'LineWidth', 2); hold on; 
plot(Median_ReactTime_FalseAlarm, '-or', 'LineWidth', 2);

plot(x, 2000+median_reaction_time_Hit_OptoStim, '--ob', 'LineWidth', 1.5);
plot(x, 2000+median_reaction_time_Hit_NoStim, '--ob', 'LineWidth', 1.5);
plot(x, 2000+median_reaction_time_FalseAlarm_OptoStim, '--or', 'LineWidth', 1.5);
plot(x, 2000+median_reaction_time_FalseAlarm_NoStim, '--or', 'LineWidth', 1.5);
% 
% PlotterTwoLines_opto(1, 2, [0, 0, numOptoDays,4000], median_reaction_time_Hit_OptoStim(mouse_ID ,:), median_reaction_time_Hit_NoStim(mouse_ID ,:), ...
%     [.2 .2 .8],' Opto Days', 'mS', 'Reaction Time', 0, numOptoDays,Line_width, ...
%     std_reaction_time_Hit_OptoStim(mouse_ID ,:), std_reaction_time_Hit_NoStim(mouse_ID ,:), 0.025); hold on; 
% 
% PlotterTwoLines_opto(0, 2, [0, 0, numOptoDays,4000], median_reaction_time_FalseAlarm_OptoStim(mouse_ID ,:), median_reaction_time_FalseAlarm_NoStim(mouse_ID ,:), ...
%     [.8 .2 .2],' Opto Days', 'mS', 'Reaction Time', 0, numOptoDays,Line_width,...
%     std_reaction_time_FalseAlarm_OptoStim(mouse_ID ,:), std_reaction_time_FalseAlarm_NoStim(mouse_ID ,:), 0); hold on; 
axis([0, num_days, 0, 4000]);
xlabel('Num Days'); ylabel('Reaction time'); title('Reaction Time');
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:1:num_days]);


%% second figure --> ratio vars
fig = figure;
titlestring = sprintf([MouseName, '  Opto Stim - No Stim']);
set(gcf,'numbertitle','off','name',titlestring);

m = 3;
n = 1;

% Plotting tone efficiencies
ax1 = subplot(m,n,2); 
plot(ToneEff_GO(:, mouse_ID), '-ob', 'LineWidth',  2); hold on;
plot(ToneEff_NOGO(:, mouse_ID), '-or', 'LineWidth',  2);
plot([firstOptoDay-0.5, firstOptoDay-0.5], [0, 100],...
    '--','Color', 'w',  'LineWidth', 0.5);

xlabel('Num Days'); ylabel('Tone Eff.'); title('Tone Efficiency');
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:1:num_days]);


ax2 = subplot(m,n,3);
labels = cell(num_days-firstOptoDay,1);
for i=1:num_days-firstOptoDay+1
    labels{i} = [num2str(i+firstOptoDay-1)];
end
PlotterTwoLines_opto(1, 1,[0, 0, numOptoDays,100], tone_eff_GO_OptoStim(mouse_ID, :), tone_eff_GO_NoStim(mouse_ID, :), ...
    [.2 .2 .9],' Opto Days', '%', 'Tone Efficiency', 0, numOptoDays,Line_width); hold on; 
PlotterTwoLines_opto(0, 1,[0, 0, numOptoDays,100], tone_eff_NOGO_OptoStim(mouse_ID, :), tone_eff_NOGO_NoStim(mouse_ID, :), ...
    [.9 .2 .2],' Opto Days', '%', 'Tone Efficiency', 0, numOptoDays,Line_width);
axis([0 numOptoDays 0 100]); set(gca, 'xticklabels', labels)

subplot(m,n,1); 
plot(DiscrIndex, '- o','Color', [.8, .8, .8], 'LineWidth', Width_lines); hold on;
plot(B, '- m o', 'LineWidth', Width_lines);
X = zeros(1,length(DiscrIndex)); x = ones(1,length(ToneEff_NOGO))*0.5;
plot(X, '- w'); plot(x, 'w --'); plot(-x, 'w --'); 
plot([firstOptoDay-0.5, firstOptoDay-0.5], [-1, 1],...
    '--','Color', 'w',  'LineWidth', 0.5);
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:1:num_days]);
legend('Discrimination index','Bias Index'); title('Discrimination Index');
xlabel('Training Days'); ylabel('-');


%% third figure --> other vars
fig = figure;
titlestring = sprintf([MouseName, '  Opto Stim - No Stim']);
set(gcf,'numbertitle','off','name',titlestring);

m = 2;
n = 1;

% Number of trials to next correct
% Plotting Discr. and Bias Index


% Plotting Num. Trials between correct trial
subplot(m,n,1); 
errorbar(Tr2Corr_avg, Tr2Corr_sem, '- o','Color', [.8, .8, .8], 'LineWidth', Width_lines); hold on;
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:1:num_days]);
plot([firstOptoDay-0.5, firstOptoDay-0.5], [0, max(Tr2Corr_avg+Tr2Corr_sem)],...
    '--','Color', 'w',  'LineWidth', 0.5);
title('Num. trials to Correct Trial');  xlabel('Training Days'); ylabel('Num. Tr.'); 


% Plotting Num. seconds between correct trial
subplot(m,n,2); 
errorbar(Sec2Corr_avg, Sec2Corr_sem, '- o','Color', [.8, .8, .8], 'LineWidth', Width_lines); hold on;
plot([firstOptoDay-0.5, firstOptoDay-0.5], [0, max(Sec2Corr_avg+Sec2Corr_sem)],...
        '--','Color', 'w',  'LineWidth', 0.5);
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:1:num_days]);
title('Seconds to Correct Trial');  xlabel('Training Days'); ylabel('Sec');


