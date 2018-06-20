function PlotterTwoLines_opto(RCheck, PlotType, Rpos, Var1, Var2,LinCol, xlbl, ylbl, ttl, startXAxis, num_days,Line_width, varargin)
% Plot Background Color
if RCheck
    rectangle('Position', Rpos, 'FaceColor', [0.2 0.2 .2], 'EdgeColor', [1 1 1]); hold on;
end

% Check if two varibles have same length, they need to. 
if size(Var1) ~= size(Var2)
    error('Couldnt complete operation, variables have different size'); 
end

if ~isempty(varargin)
    error1 = varargin{1};
    error2 = varargin{2};
    offset = varargin{3}; 
end

% Plot
for i = 1:num_days-1
    if RCheck
        plot([i-0.2, i-0.2], [Rpos(2), Rpos(4)], '-- k');
        plot([i+0.2, i+0.2], [Rpos(2), Rpos(4)], '-- k');
    end
    
    if PlotType == 1
        plot([i-0.2, i+0.2], [Var1(i), Var2(i)],'- o', 'color', LinCol, 'LineWidth', Line_width + 1.25);
    elseif PlotType == 2
        errorbar([i-0.2 - offset, i+0.2 - offset], [Var1(i), Var2(i)],[error1(i), error2(i)], '- o','color', LinCol, 'LineWidth', Line_width+ 1.25);
    end
end


% Set looks
title(ttl); grid on;
axis([startXAxis num_days 0 inf]);
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:1:num_days]);
xlabel(xlbl); ylabel(ylbl); 
end

