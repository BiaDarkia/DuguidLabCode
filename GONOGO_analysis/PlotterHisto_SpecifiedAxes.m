function PlotterHisto_SpecifiedAxes ( RPos, HVar, HCol1, HCol2, HCol3, Pvar, PCol, ttl, xlbl, ylbl, Line_width, Width_lines, Mod2Start,num_days)
% Plot Background Color
rectangle('Position', RPos, 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', [1 1 1]); hold on;

% Plot Histogram and adjust aspect
a = bar(HVar', 'stacked');
a(1).FaceColor = HCol1;  a(2).FaceColor = HCol1; 
a(3).FaceColor = HCol2;  a(4).FaceColor = HCol2; 
a(5).FaceColor = HCol3;  a(6).FaceColor = HCol3;
a(1).LineWidth = Line_width; a(2).LineWidth = Line_width; a(3).LineWidth = Line_width;
a(4).LineWidth = Line_width; a(5).LineWidth = Line_width; a(6).LineWidth = Line_width;
a(1).EdgeColor = [0 0 0]; a(2).EdgeColor = [0 0 0]; a(3).EdgeColor = [0 0 0];
a(4).EdgeColor = [0 0 0]; a(5).EdgeColor = [0 0 0]; a(6).EdgeColor = [0 0 0];

% Plot solid line
plot(Pvar, ['-',PCol,'o'], 'LineWidth', Width_lines);
title(ttl); grid on;
axis([Mod2Start num_days 0 inf]);
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
xlabel(xlbl); ylabel(ylbl); 



end

