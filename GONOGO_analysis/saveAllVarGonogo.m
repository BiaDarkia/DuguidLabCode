function [filename] = saveAllVar(mouseID, mouse, all_var, Reanalyse)
% saveAllVar saves all variables (all_var) generated in the lever training
% analysis script

MetaPathList

if Reanalyse ~= 1
    if ~isempty(mouse.name{mouseID})
        
        filename=sprintf('%s_analysed.mat',mouse.name{mouseID});
        save(filename,'all_var');
        fprintf('Saving all final variables to\n%s\n',filename);
        
    end
else
    if ~isempty(mouse.name{mouseID})
    filename=sprintf('%s_analysed.mat',mouse.name{mouseID});
    OldVar = load(filename); 
    OldVar = OldVar.all_var; 
    end
end
end

