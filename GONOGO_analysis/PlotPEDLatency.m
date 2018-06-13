%% INTRO

% This script plot the latency to push for preemptives delay of mice doing
% a Go/Nogo task. The latency is calculated from tone onset, not delay
% onset. Each day is plotted in a different subplot, the vertical line
% signals the time at which the tone ends. 

%% Setting up 



PlotArea = 1; % ~=0 to plot histogram , =1 to plot areas, =2 to plot as "slideshow"
PlotTot = 0; % =1 to plot the same latency plot but for the sum of all pushes 

clear PED_times
clear HIT_times
clear FA_times

BinWidthSize = 200; 

PED_times = all_var.PE_delay_times; 
PED_times(PED_times == 0) = NaN; 

HIT_times  = all_var.reaction_time_Hit_TOT; 
HIT_times(HIT_times == 0) = NaN; 

FA_times  = all_var.reaction_time_FA_TOT; 
FA_times(FA_times == 0) = NaN; 

FA_start = find(FA_times > 0, 1); 
FA_start = round(FA_start / size(FA_times,1)); 


Mod2Start = find(DayMode(:,mouse_ID) == 2,1);
DaysToPlot = num_days - Mod2Start;

Del_Mins = all_var.delay_day_min; 
Del_Mins(Del_Mins == 0) = NaN;
Del_Maxs = all_var.delay_day_max; 
Del_Maxs( Del_Maxs == 0) = NaN;

TOT_times = zeros(500,1); 

n = 5; % Columns of subplots
m = roundn(DaysToPlot/n,0); % Num of rows of subplots

if m*n < DaysToPlot
    m = m+1;
end


% Title
FigTitle = ['PED Latency ', MouseName];
PlotNum = 0;
%% Plotting single days

    
    fig = figure;
    set(gcf,'numbertitle','off','name',FigTitle)
    
    legendCheck = 0;
    
    if PlotArea == 0            % Plotting Histogram
        for i = 1:DaysToPlot
            
            P = i + Mod2Start;
            
            subplot(m,n,i);
            a = histogram(PED_times(:,P), 'BinWidth', BinWidthSize); hold on;
            a.FaceColor = [0.5 1 0.5];
            a.FaceAlpha = 0.75;
            
            b = histogram(HIT_times(:,P), 'BinWidth', BinWidthSize);
            b.FaceColor = [0.5 0.5 1];
            b.FaceAlpha = 0.75;
            
            c = histogram(FA_times(:,P), 'BinWidth', BinWidthSize);
            c.FaceColor = [1 0.5 0.5];
            c.FaceAlpha = 0.75;
            
            xx = [600,600];
            yy = [0, 30];
            plot(xx,yy, 'k --');
            
            axis([0 2000 0 inf]);
            PlotNum = PlotNum+1;
            TitleName = ['Session ' num2str(i + Mod2Start)];
            title(TitleName);
            
            xlabel('Msec'), ylabel('Num');
            set(gca,'XTickMode','manual'); set(gca,'XTick',[0:500:2500]);
            
            if legendCheck == 0
                legend('PED', 'HIT', 'FA');
                legendCheck = 1;
            end
        end
    elseif PlotArea == 1        % Plotting Areas
        for i = 1:DaysToPlot
            
            P = i + Mod2Start;
            
            DelMinx = [Del_Mins(P)+600 Del_Mins(P)+600];
            DelMaxx = [Del_Maxs(P)+600 Del_Maxs(P)+600];
            xx = [600,600];
            yy = [0, 30];
            
            [N_PED, E_PED] = histcounts(PED_times(:,P), 'BinWidth', BinWidthSize);
            [N_HIT, E_HIT] = histcounts(HIT_times(:,P), 'BinWidth', BinWidthSize);
            [N_FA, E_FA]   = histcounts(FA_times(:,P), 'BinWidth', BinWidthSize);
            
            
            % Rearranging stuff for plotting
            E_PED = E_PED(2:end); E_PED = E_PED - 100;
            E_HIT = E_HIT(2:end); E_HIT = E_HIT - 100;
            E_FA = E_FA(2:end); E_FA = E_FA - 100;
            
            
            subplot(m,n,i);
            a = area(E_PED, N_PED, 'FaceColor', [0.5 1 0.5], 'FaceAlpha', 0.5); hold on;
            b = area(E_HIT, N_HIT, 'FaceColor', [0.5 0.5 1], 'FaceAlpha', 0.5);
            c = area(E_FA, N_FA, 'FaceColor', [1 0.5 0.5], 'FaceAlpha', 0.5);
            plot(xx,yy, 'k --');
            plot(DelMinx,yy, 'k');
            plot(DelMaxx,yy, 'k');
            
            axis([0 2000 0 inf]);
            xlabel(''), ylabel('');
            set(gca,'XTickMode','manual'); set(gca,'XTick',[0:500:2500]);
            PlotNum = PlotNum+1;
            TitleName = ['Session ' num2str(i + Mod2Start)];
            title(TitleName);
            
            if legendCheck == 0
                legend('PED', 'HIT', 'FA');
                legendCheck = 1;
            end
        end
    elseif PlotArea == 2        % Plot as Slideshow
        for i = 1:DaysToPlot
            
            xx = [600,600];
            DelMinx = [Del_Mins(P)+600 Del_Mins(P)+600];
            DelMaxx = [Del_Maxs(P)+600 Del_Maxs(P)+600];
            yy = [0, 30];
            
            P = i + Mod2Start;
            
            
            [N_PED, E_PED] = histcounts(PED_times(:,P), 'BinWidth', BinWidthSize);
            [N_HIT, E_HIT] = histcounts(HIT_times(:,P), 'BinWidth', BinWidthSize);
            [N_FA, E_FA]   = histcounts(FA_times(:,P), 'BinWidth', BinWidthSize);
            
            % Rearranging stuff for plotting
            E_PED = E_PED(2:end); E_PED = E_PED - 100;
            E_HIT = E_HIT(2:end); E_HIT = E_HIT - 100;
            E_FA = E_FA(2:end); E_FA = E_FA - 100;
            
            a = area(E_PED, N_PED, 'FaceColor', [0.5 1 0.5], 'FaceAlpha', 0.5); hold on;
            b = area(E_HIT, N_HIT, 'FaceColor', [0.5 0.5 1], 'FaceAlpha', 0.5);
            c = area(E_FA, N_FA, 'FaceColor', [1 0.5 0.5], 'FaceAlpha', 0.5);
            plot(xx,yy, 'k --');
            plot(DelMinx,yy, 'k');
            plot(DelMaxx,yy, 'k');
            
            axis([0 2000 0 inf]);
            xlabel('Msec'), ylabel('Num');
            set(gca,'XTickMode','manual'); set(gca,'XTick',[0:500:2500]);
            PlotNum = PlotNum+1;
            TitleName = ['Session ' num2str(i + Mod2Start)];
            title(TitleName);
            
            if legendCheck == 0
                legend('PED', 'HIT', 'FA');
                legendCheck = 1;
            end
            
            if i < DaysToPlot-2
                pause(0.5);
                clf;
            else
                %      pause;
            end
        end
    end
    
    %% Plot TOT
    % Plots the same plot, but with the sum of all psuhes together (only works
    % with the Plot Areas type of plot.
    if PlotTot == 1
        fig3 = figure;
        Fig3Title = ['Latency of all pushes - ', MouseName];
        set(gcf,'numbertitle','off','name', Fig3Title);
        
        for i = 1:DaysToPlot
            clear TOT_times;
            TOT_times = [PED_times(:,P); HIT_times(:,P); FA_times(:,P)];
            TOT_times(find(isnan(TOT_times))) = [];
            
            P = i + Mod2Start;
            
            DelMinx = [Del_Mins(P)+600 Del_Mins(P)+600];
            DelMaxx = [Del_Maxs(P)+600 Del_Maxs(P)+600];
            xx = [600,600];
            yy = [0, 60];
            
            [N_TOT, E_TOT] = histcounts(TOT_times, 'BinWidth', BinWidthSize);
            E_TOT = E_TOT(2:end); E_TOT = E_TOT - 100;
            
            
            subplot(m,n,i);
            a = area(E_TOT, N_TOT, 'FaceColor', [0.6 0.6 0.6], 'FaceAlpha', 0.5); hold on;
            plot(xx,yy, 'k --');
            plot(DelMinx,yy, 'k');
            plot(DelMaxx,yy, 'k');
            
            axis([0 2000 0 inf]);
            xlabel('Msec'), ylabel('Num');
            set(gca,'XTickMode','manual'); set(gca,'XTick',[0:500:2500]);
            PlotNum = PlotNum+1;
            TitleName = ['Session ' num2str(i + Mod2Start)];
            title(TitleName);
        end
    end
    
    %% plotting avarages of first and last 5 days
    
    
    fig2 = figure;
    Fig2Title = ['Beginner vs Expert Latency ', MouseName];
    set(gcf,'numbertitle','off','name', Fig2Title);
    
    
    %PED
    PED_begArray = PED_times(:, Mod2Start:Mod2Start+4);
    PED_expArray = PED_times(:, DaysToPlot-(DaysToPlot/4):DaysToPlot);
    
    edges = 1:200:1600;
    
    for i = 1: size(PED_times(:, DaysToPlot-(DaysToPlot/4):DaysToPlot-1),2)
        N_PEDbArray(:,i) = histcounts(PED_begArray(:,i), edges);
        N_PEDeArray(:,i) = histcounts(PED_expArray(:,i), edges);
    end
    
    N_PEDb = mean(N_PEDbArray,2);
    N_PEDe = mean(N_PEDeArray,2);
    
    PED_bAvg = mean(mean(PED_begArray,1,'omitnan'));
    PED_eAvg = mean(mean(PED_expArray,1,'omitnan'));
    
    % Plotting
    subplot(4,1,1);
    d = area(1:200:200*size(N_PEDb,1), N_PEDb, 'FaceColor', [0.2 0.6 0.3], 'FaceAlpha', 0.5); hold on;
    e = area(1:200:200*size(N_PEDe,1), N_PEDe, 'FaceColor', [0.6 1 0.6], 'FaceAlpha', 0.5, 'EdgeColor', [0.7 0.7 0.7]);
    xx = [600,600];
    yy = [0, 30];
    plot(xx,yy, 'k --');
    plot([PED_bAvg PED_bAvg], [0, max(max([N_PEDb N_PEDe]))], 'Color', [0.2 0.6 0.3]);
    plot([PED_eAvg PED_eAvg], [0, max(max([N_PEDb N_PEDe]))], 'Color', [0.6 1 0.6]);
    axis([0 inf 0 inf]);         xlabel('Msec'), ylabel('Num');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[0:250:10000]);
    legend('Beginner', 'Expert');
    title('PED');
    
    
    %HIT
    HIT_begArray = HIT_times(:, Mod2Start:Mod2Start+4);
    HIT_expArray = HIT_times(:, DaysToPlot-(DaysToPlot/4):DaysToPlot);
    
    edges = 1:200:5000;
    
    for i = 1: size(PED_times(:, DaysToPlot-(DaysToPlot/4):DaysToPlot-1),2)
        N_HITbArray(:,i) = histcounts(HIT_begArray(:,i), edges);
        N_HITeArray(:,i) = histcounts(HIT_expArray(:,i), edges);
    end
    
    N_HITb = mean(N_HITbArray,2);
    N_HITe = mean(N_HITeArray,2);
    
    HIT_bAvg = mean(mean(HIT_begArray,1,'omitnan'));
    HIT_eAvg = mean(mean(HIT_expArray,1,'omitnan'));
    
    % Plotting
    subplot(4,1,2);
    d = area(1:200:200*size(N_HITb,1), N_HITb, 'FaceColor', [0.2 0.2 0.6], 'FaceAlpha', 0.5); hold on;
    e = area(1:200:200*size(N_HITe,1), N_HITe, 'FaceColor', [0.6 0.6 1], 'FaceAlpha', 0.5, 'EdgeColor', [0.7 0.7 0.7]);
    xx = [600,600];
    yy = [0, 30];
    plot(xx,yy, 'k --');
    plot([HIT_bAvg HIT_bAvg], [0, max(max([N_HITb N_HITe]))], 'Color', [0.2 0.2 0.6]);
    plot([HIT_eAvg HIT_eAvg], [0, max(max([N_HITb N_HITe]))], 'Color', [0.6 0.6 1]);
    axis([0 inf 0 inf]);         xlabel('Msec'), ylabel('Num');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[0:250:10000]);
    legend('Beginner', 'Expert');
    title('HIT');
    
    %FA
    FA_begArray = FA_times(:, FA_start:FA_start+4);
    FA_expArray = FA_times(:, DaysToPlot-(DaysToPlot/4):DaysToPlot);
    
    edges = 1:200:5000;
    
    for i = 1: size(PED_times(:, DaysToPlot-(DaysToPlot/4):DaysToPlot-1),2)
        N_FAbArray(:,i) = histcounts(FA_begArray(:,i), edges);
        N_FAeArray(:,i) = histcounts(FA_expArray(:,i), edges);
    end
    
    N_FAb = mean(N_FAbArray,2);
    N_FAe = mean(N_FAeArray,2);
    
    FA_bAvg = mean(mean(FA_begArray,1,'omitnan'));
    FA_eAvg = mean(mean(FA_expArray,1,'omitnan'));
    
    %Plotting
    subplot(4,1,3);
    d = area(1:200:200*size(N_FAb,1), N_FAb, 'FaceColor', [0.6 0.2 0.2], 'FaceAlpha', 0.5); hold on;
    e = area(1:200:200*size(N_FAe,1), N_FAe, 'FaceColor', [1 0.6 0.6], 'FaceAlpha', 0.5, 'EdgeColor', [0.7 0.7 0.7]);
    xx = [600,600];
    yy = [0, 30];
    plot(xx,yy, 'k --');
    plot([FA_bAvg FA_bAvg], [0, max(max([N_FAb N_FAe]))], 'Color', [0.6 0.2 0.2]);
    plot([FA_eAvg FA_eAvg], [0, max(max([N_FAb N_FAe]))], 'Color', [1 0.6 0.6]);
    axis([0 inf 0 inf]);         xlabel('Msec'), ylabel('Num');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[0:250:10000]);
    legend('Beginner', 'Expert');
    title('FA');
    
    
    %PED-HIT-FA together
    N_HITb(1:length(N_PEDb)) = [N_HITb(1:length(N_PEDb)) + N_PEDb];
    N_HITe(1:length(N_PEDe)) = [N_HITe(1:length(N_PEDe)) + N_PEDe];
    
    N_TOTb = [N_HITb + N_FAb];
    N_TOTe = [N_HITe + N_FAe];
    
    TOT_bMedian = median(N_HITb);
    TOT_eMedian = median(N_HITe );
    
    Xaxis = [1:200:200*size(N_TOTb,1)];
    
    subplot(4,1,4);
    d = area(Xaxis, N_TOTb, 'FaceColor', [0.3 0.3 0.3], 'FaceAlpha', 0.5); hold on;
    e = area(Xaxis, N_TOTe, 'FaceColor', [0.7 0.7 0.7], 'FaceAlpha', 0.5, 'EdgeColor', [0.7 0.7 0.7]);
    xx = [600,600];
    yy = [0, 30];
    plot(xx,yy, 'k --');
    axis([0 inf 0 inf]);         xlabel('Msec'), ylabel('Num');
    set(gca,'XTickMode','manual'); set(gca,'XTick',[0:250:10000]);
    legend('Beginner', 'Expert');
    title('ALL');
    
