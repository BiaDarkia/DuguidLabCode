% This script is for plotting the data relative to GoNoGo of a whole cohort
% combined in one figure.

%% Set up

IndividualTraces = 1; % If = 1 the plots will have the cohort mean as thick solid line and
% the traces for each mouse as thin dotted line, otherwise only the mean
% will be shown  [ Only works with 1 at the moment]

rows = 3;
columns = 2;

MeanLine = 3.5; %Width of the means lines
IndLine = 0.75; %Width of the individuals lines

%% Handle strings and variables
CohortName = MouseName(1:length(MouseName)-1);
Mod2Start = find(DayMode(:,mouse_ID) == 2,1)-0.5;

FalseAlarms(FalseAlarms == 0) = NaN;
ToneEff_NOGO(ToneEff_NOGO == 0) = NaN;
Median_ReactTime_FalseAlarm(Median_ReactTime_FalseAlarm == 0) = NaN;

x = 1:num_days;

%% D'
% Hit rate and FA rate
HR = ToneEff_GO(1:end,:)./100;
FAR = (100 - ToneEff_NOGO(1:end,:))./100;

% Remove NaNs
FAR(isnan(FAR)) = 0;

% Spec Index
d = HR - FAR;

%Do stuff for plotting
a = nan(1,numMatFiles);
d = [a; d];

%% Criterion (C)
% C reflects how likely is a mouse to push regardles of the trial tipe.
% e.g. if C is high the mouse pushes a lot in general.

c = (HR + FAR)./2;
c = [a; c];

%% Plotting with indidivudal mice traces
if IndividualTraces == 1
    fig = figure;
    set(gcf,'numbertitle','off','name',CohortName)
    
    subplot(columns,rows,1); %Rewards
    plot(Hits+CorrectRejections, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', IndLine); hold on;
    plot(mean(Hits+CorrectRejections,2,'omitnan'), '-', 'LineWidth', MeanLine, 'Color', [0.2, 0.2, 1]);
    axis([1, num_days, 0, inf]);
    xlabel('Training days'), ylabel('Rews'); title('Rewards');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    grid on; hold off;
    
    subplot(columns,rows,2); %Misses/FA
    plot(Misses, '--', 'Color', [0.3 0.3 0.7], 'LineWidth', IndLine); hold on;
    plot(mean(Misses,2,'omitnan'), '-', 'LineWidth', MeanLine, 'Color', [0.2, 0.2, 1]);
    plot(FalseAlarms, '--', 'Color', [0.7 0.3 0.3], 'LineWidth', IndLine); hold on;
    plot(mean(FalseAlarms,2,'omitnan'), '-', 'LineWidth', MeanLine, 'Color', 'r');
    axis([1, num_days, 0, inf]);
    xlabel('Training days'), ylabel('Errors'); title('Misses / Fa');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    grid on; hold off;
    
    subplot(columns,rows,3); %PE TOT
    plot(Preemptives_TOT, '--', 'Color', [0.5 0.5 0.5], 'LineWidth', IndLine); hold on;
    plot(mean(Preemptives_TOT,2,'omitnan'), '-', 'LineWidth', MeanLine, 'Color', 'g'); hold on;
    axis([1, num_days, 0, inf]);
    xlabel('Training days'), ylabel('PE'); title('preemptives');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    grid on; hold off;
    
    subplot(columns,rows,4); %TE Go and NOGO
    plot(ToneEff_GO, '--', 'Color', [0.3 0.3 0.7], 'LineWidth', IndLine); hold on;
    plot(mean(ToneEff_GO,2,'omitnan'), '-', 'LineWidth', MeanLine, 'Color', [0.2, 0.2, 1]);
    plot(ToneEff_NOGO, '--', 'Color', [0.7 0.3 0.3], 'LineWidth', IndLine); hold on;
    plot(mean(ToneEff_NOGO,2, 'omitnan'), '-', 'LineWidth', MeanLine, 'Color', [1, 0.2, 0.2]);
    axis([1, num_days, 0, inf]);
    xlabel('Training days'), ylabel('TE'); title('Tone Efficiency');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    grid on; hold off;
    
    subplot(columns,rows,5); %RT
    plot(Median_ReactTime_Hit, '--', 'Color', 'b', 'LineWidth', IndLine); hold on;
    plot(Median_ReactTime_FalseAlarm, '--', 'Color', 'r', 'LineWidth', IndLine); hold on;
    plot(mean(Median_ReactTime_Hit,2,'omitnan'), '- b', 'LineWidth',MeanLine);
    plot(mean(Median_ReactTime_FalseAlarm,2,'omitnan'), '- r', 'LineWidth',MeanLine);
    axis([1, num_days, 0, inf]);
    xlabel('Training days'), ylabel('RT'); title('Reaction Time ');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    grid on; hold off;
    
    subplot(columns, rows, 6); %d'
    plot(d, '-- k', 'LineWidth', IndLine); hold on;
    y = zeros(1, num_days-Mod2Start+.5); plot(y, 'k --');
    plot(mean(d,2,'omitnan'), '- k', 'LineWidth', MeanLine);
    axis([1, num_days, -1, 1]);
    xlabel('Training days'), ylabel('d'''); title('Disc. Index');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    grid on; hold off;
else
    %% Plot without individual mice
    fig = figure;
    set(gcf,'numbertitle','off','name',CohortName)
    
    subplot(columns,rows,1); %Rewards
    shadedErrorBar(x,  mean(Hits+CorrectRejections,2,'omitnan'), std(Hits+CorrectRejections,0,2), '- b',1); hold on;
    plot(mean(Hits+CorrectRejections,2,'omitnan'), '-', 'LineWidth', 2, 'Color', [0.2, 0.2, 1]);
    axis([Mod2Start, num_days, 0, inf]);
    xlabel('Training days'), ylabel('Rews'); title('Rewards');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    grid on; hold off;
    
    subplot(columns,rows,2); %Misses/FA
    shadedErrorBar(x,  mean(Misses,2,'omitnan'), std(Misses,0,2,'omitnan'), '- b',1); hold on;
    plot(mean(Misses,2,'omitnan'), '-', 'LineWidth', 2, 'Color', [0.2, 0.2, 1]);
    shadedErrorBar(x,  mean(FalseAlarms,2,'omitnan'), std(FalseAlarms,0,2,'omitnan'), '- r',1);
    plot(mean(FalseAlarms,2,'omitnan'), '-', 'LineWidth', 2, 'Color', 'r');
    axis([Mod2Start, num_days, 0, inf]);
    xlabel('Training days'), ylabel('Errors'); title('Misses / Fa');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    grid on; hold off;
    
    subplot(columns,rows,3); %PE TOT
    shadedErrorBar(x,  mean(Preemptives_TOT,2,'omitnan'), std(Preemptives_TOT,0,2,'omitnan'), '- g',1);hold on;
    plot(mean(Preemptives_TOT,2,'omitnan'), '--', 'Color', 'g'); hold on;
    axis([Mod2Start, num_days, 0, inf]);
    xlabel('Training days'), ylabel('PE'); title('preemptives');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    grid on; hold off;
    
    subplot(columns,rows,4); %TE Go and NOGO
    plot(mean(ToneEff_GO,2,'omitnan'), '-', 'LineWidth', 2, 'Color', [0.2, 0.2, 1]);hold on;
    plot(mean(ToneEff_NOGO,2, 'omitnan'), '-', 'LineWidth', 2, 'Color', [1, 0.2, 0.2]);
    shadedErrorBar(x,  mean(ToneEff_TOT,2,'omitnan'), std(ToneEff_TOT,0,2,'omitnan'), '- k',1);
    XX = ones(1,length(ToneEff_NOGO))*75;
    plot(XX, 'k --');
    axis([Mod2Start, num_days, 0, inf]);
    xlabel('Training days'), ylabel('TE'); title('Tone Efficiency');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    grid on; hold off;
    
    subplot(columns,rows,5); %RT
    shadedErrorBar(x,  mean(Median_ReactTime_Hit,2,'omitnan'), std(Median_ReactTime_Hit,0,2,'omitnan'), '- b',1);hold on;
    shadedErrorBar(x,  mean(Median_ReactTime_FalseAlarm,2,'omitnan'), std(Median_ReactTime_FalseAlarm,0,2,'omitnan'), '- r',1);
    axis([Mod2Start, num_days, 0, inf]);
    xlabel('Training days'), ylabel('RT'); title('Reaction Time ');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    grid on; hold off;
    
    subplot(columns, rows, 6); %d'
    shadedErrorBar(x, mean(c,2,'omitnan'), std(c,0,2,'omitnan'), '- m');   hold on;
    shadedErrorBar(x, mean(d,2,'omitnan'),std(d,0,2,'omitnan'), '- k');
    xx = ones(1,length(ToneEff_NOGO))*0.5;
    plot(xx, 'k --');
    y = zeros(1, num_days-Mod2Start+.5); plot(y, 'k --');
    axis([Mod2Start, num_days, -1, 1]);
    xlabel('Training days'), ylabel('d'''); title('Disc. Index');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    legend('Criterion index','','','',  'Discrimination index', 'Position', 'SouthWest');
    grid on; hold off;
    
end

