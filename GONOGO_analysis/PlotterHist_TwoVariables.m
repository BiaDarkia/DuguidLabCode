function PlotterHist_TwoVariables( RPos, HVar1,HVar2, HCol1, HCol2, HCol3, ttl, xlbl, ylbl, Line_width, startXAxis,num_days)
% Plot Background Color
rectangle('Position', RPos, 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', [1 1 1]); hold on;

% Check if two varibles have same length, they need to. 
if size(HVar1) ~= size(HVar2)
    error('Couldnt complete operation, variables have different size'); 
end

% Set up x axes for bar plots
val1 = 0.13;
X1 = linspace(1-val1, (num_days-1)-val1, num_days-1);
X2 = linspace(1+val1, (num_days-1)+val1, num_days-1); 

% Plot histograms
h1 = bar(X1, HVar1', 0.25, 'stacked');
h2 = bar(X2, HVar2', 0.25, 'stacked');

% Set Appearence
h1(1).FaceColor = HCol1;  h1(2).FaceColor = HCol1; 
h1(3).FaceColor = HCol2;  h1(4).FaceColor = HCol2; 
h1(5).FaceColor = HCol3;  h1(6).FaceColor = HCol3;
h1(1).LineWidth = Line_width; h1(2).LineWidth = Line_width; h1(3).LineWidth = Line_width;
h1(4).LineWidth = Line_width; h1(5).LineWidth = Line_width; h1(6).LineWidth = Line_width;
h1(1).EdgeColor = [0 0 0]; h1(2).EdgeColor = [0 0 0]; h1(3).EdgeColor = [0 0 0];
h1(4).EdgeColor = [0 0 0]; h1(5).EdgeColor = [0 0 0]; h1(6).EdgeColor = [0 0 0];

h2(1).FaceColor = HCol1;  h2(2).FaceColor = HCol1; 
h2(3).FaceColor = HCol2;  h2(4).FaceColor = HCol2; 
h2(5).FaceColor = HCol3;  h2(6).FaceColor = HCol3;
h2(1).LineWidth = Line_width; h2(2).LineWidth = Line_width; h2(3).LineWidth = Line_width;
h2(4).LineWidth = Line_width; h2(5).LineWidth = Line_width; h2(6).LineWidth = Line_width;
h2(1).EdgeColor = [0 0 0]; h2(2).EdgeColor = [0 0 0]; h2(3).EdgeColor = [0 0 0];
h2(4).EdgeColor = [0 0 0]; h2(5).EdgeColor = [0 0 0]; h2(6).EdgeColor = [0 0 0];

% Set looks
title(ttl); grid on;
axis([startXAxis num_days 0 inf]);
set(gca,'XTickMode','manual'); set(gca,'XTick',[1:1:num_days]);
xlabel(xlbl); ylabel(ylbl); 

end

