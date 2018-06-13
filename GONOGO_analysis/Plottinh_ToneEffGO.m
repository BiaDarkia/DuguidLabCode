function Plottinh_ToneEffGO ( VARFileName, mouse_ID, TimedStatus)

load(VARFileName, '-mat', 'Color1');
load(VARFileName, '-mat', 'Color2');
load(VARFileName, '-mat', 'Color3');
load(VARFileName, '-mat', 'Color4');
load(VARFileName, '-mat', 'Color5');
load(VARFileName, '-mat', 'Color6');
load(VARFileName, '-mat', 'all_var');
load(VARFileName, '-mat', 'Mod2Start');
load(VARFileName, '-mat', 'num_days');
load(VARFileName, '-mat', 'Axis_Tone');
load(VARFileName, '-mat', 'Width_lines');
load(VARFileName, '-mat', 'Line_width');
load(VARFileName, '-mat', 'Hit_timed');
load(VARFileName, '-mat', 'ToneEff_GO');
    load(VARFileName, '-mat', 'ToneEff_NOGO');
    load(VARFileName, '-mat', 'ToneEffTot');
    load(VARFileName, '-mat', 'GO_TE_timed');
    
    
    if TimedStatus == 0
    plot(ToneEff_GO(:,mouse_ID), '- b o', 'LineWidth', Width_lines); hold on;
    plot(ToneEff_NOGO(:,mouse_ID), '-- r o');
    plot(ToneEffTot, '-- k o');
    a = bar(GO_TE_timed);
    plot(ToneEff_GO(:,mouse_ID), '- b o', 'LineWidth', Width_lines); % Repeated twice to have them in the legend but plotted in fron of the bars
    plot(ToneEff_NOGO(:,mouse_ID), '-- r o');
    plot(ToneEffTot, '-- k o', 'LineWidth', Width_lines);
    title('Tone Efficiency'); legend('GO', 'NOGO', 'TOT');
    grid on;
    a(1).FaceColor = Color1; a(2).FaceColor = Color3; a(3).FaceColor = Color6;
    a(1).LineWidth = Line_width; a(2).LineWidth = Line_width; a(3).LineWidth = Line_width;
    a(1).EdgeColor = [0 0 0]; a(2).EdgeColor = [0 0 0]; a(3).EdgeColor = [0 0 0];
    axis([Mod2Start size(Hit_timed',1)+0.5 0 inf]);
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    xlabel('Training Days'); ylabel('%');
    else
            plot(ToneEff_GO(:,mouse_ID), '- b o', 'LineWidth', Width_lines); hold on;
    plot(ToneEff_NOGO(:,mouse_ID), '-- r o');
    plot(ToneEffTot, '-- k o');
    title('Tone Efficiency'); legend('GO', 'NOGO', 'TOT');
    grid on;axis([Mod2Start size(Hit_timed',1)+0.5 0 inf]);
    set(gca,'XTickMode','manual'); set(gca,'XTick',[1:2:num_days]);
    xlabel('Training Days'); ylabel('%');
    end

end

