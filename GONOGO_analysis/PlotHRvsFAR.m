%% This scripts plots Hit Ratio vs False Alarms Ratio for each daily session for 1 mouse

% Plots the timed analysis of the hit rate, false alarm rate and
% discrimination index rate using a sliding window avarage. 


% This function generates a figure for each of the mice being plotted.
% IN this figure each training session is represented as an individual
% subplot. In each subplot the points indicate the ratio beween hit
% rate (Y axis) and false alarm rate (X axis). The label of each data
% point represents the discrimination index value for at that time.

% SET UP
% Sliding window - set up      <--- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Wnd = 600000; % Length of the window
StepNum = 100; 
Step = Wnd/StepNum; % step wise sliding 
WndNum = 1; %flag for how many steps, needed to save variables correctly


% PLOT FOR NORMAL DATA
% Get start of mode 2 training
Mod2Start = find(DayMode(:,mouse_ID) == 2,1); %-0.5;
if isempty(Mod2Start)
    Mod2Start = 1; % If we can't find a start day let's assume it's day one
end

% Calc num of subplot
DaysToPlot = num_days - (Mod2Start - 0.5) + 1;
start_day = Mod2Start;
day_selector = 0;

n = 5; % Columns of subplots
m = roundn(DaysToPlot/n,0); % Num of rows of subplots
if m*n < DaysToPlot
    m = m+1; 
end
FigTitle = ['DI - ', MouseName];

fig = figure;
set(gcf,'numbertitle','off','name',FigTitle)
hit_times = Hit_times;
miss_times = Miss_times;
fa_times = FA_times;
cr_times = CR_times;

PlotHRvsFAR_plotter

% OPTO STIM TRIALS
DaysToPlot = num_days - firstOptoDay + 1;
start_day = 1;
day_selector = firstOptoDay-1;
n = 5; % Columns of subplots
m = roundn(DaysToPlot/n,0); % Num of rows of subplots

if m*n < DaysToPlot
    m = m+1; 
end

FigTitle = ['DI optostim - ', MouseName];

fig = figure;
set(gcf,'numbertitle','off','name',FigTitle)

hit_times = Hit_OptoStim_times;
miss_times = Miss_OptoStim_times;
fa_times = FA_OptoStim_times;
cr_times = CR_OptoStim_times;

PlotHRvsFAR_plotter

% NO STIM TRIALS
DaysToPlot = num_days - firstOptoDay + 1;
start_day = 1;
day_selector = firstOptoDay-1;

n = 5; % Columns of subplots
m = roundn(DaysToPlot/n,0); % Num of rows of subplots

if m*n < DaysToPlot
    m = m+1; 
end
FigTitle = ['DI nostim - ', MouseName];

fig = figure;
set(gcf,'numbertitle','off','name',FigTitle)

hit_times = Hit_NoStim_times;
miss_times = Miss_NoStim_times;
fa_times = FA_NoStim_times;
cr_times = CR_NoStim_times;

PlotHRvsFAR_plotter

%% Conclusion
% Add Max. Discr. Index. to all_var
all_var.MaxDiscrIndx = MaxDIW;
save(filename, 'all_var');

% discard varibales
clear MaxDIW; clear RewMaxDI; clear TimeMaxDI;

 



