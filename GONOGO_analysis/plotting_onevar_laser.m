function plotting_onevar_laser(var, var_opto, var_nopto, x, color, firstOptoDay, num_optotrials, num_noptotrials, ttl, num_days)
    % Choose colo
    if color == 'b'
        light_shade = [0.7 0.7 0.9];
        dark_shade = [0.4 0.4 0.8];
        edge_color = 'b';
    elseif color == 'r'
        light_shade = [0.9 0.7 0.7];
        dark_shade = [0.8 0.4 0.4];
        edge_color = 'r';  
    elseif color == 'g'
        light_shade = [0.7 0.9 0.7];
        dark_shade = [0.4 0.8 0.4];
        edge_color = 'g';  
    end

    % Plot main var data
    plot(var, '-o','Color', color,  'LineWidth', 2); hold on;
    h0  = bar(var(1:firstOptoDay), 0.35);
    h0(1).FaceColor = light_shade;

    % Plot opto and no opto trials data
    h = bar(x, [var_opto; var_nopto]', 0.4, 'stacked', 'EdgeAlpha', .0); 
    h(1).FaceColor = dark_shade; h(2).FaceColor = light_shade; 

    % Plot the ratio of no opto to opto trials to compare with var results
    ratio = (num_optotrials / num_optotrials+ num_noptotrials) / 100;
    h2 = bar(x-0.01, [var(firstOptoDay:end)'.*ratio]',...
        0.41, 'stacked', 'FaceAlpha',.0, 'EdgeColor',edge_color,'LineWidth',1.5); 
    % h2(1).FaceColor = dark_shade; h2(2).FaceColor = light_shade;

    % replot line
    plot(var, '-o','Color', color,  'LineWidth', 2); hold on;
    
    % mark start of otpo and label stuff
    plot([firstOptoDay-0.5, firstOptoDay-0.5], [0, max(var)], '--','Color', 'w',  'LineWidth', 0.5);
    title(ttl); 
    axis([1 num_days 0 inf]);
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:1:num_days]);
    xlabel('Num Days'); ylabel(ttl); axis([0.5, num_days+0.5, 0, inf])
end

