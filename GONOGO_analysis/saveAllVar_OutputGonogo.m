function [filename] = saveAllVarOutput(mouseID, mouse, all_varOutput, Reanalyse)
% saveAllVarOutput saves all variables (all_varOutput) generated in the lever training
% analysis script

MetaPathList

if Reanalyse ~= 1
    if ~isempty(mouse.name{mouseID})
        
        filename=sprintf('%s_analysed.mat',mouse.name{mouseID});
        save(filename,'all_varOutput');
        fprintf('Saving all final variables to\n%s\n',filename);
        
    end
else
    if ~isempty(mouse.name{mouseID})
    filename=sprintf('%s_analysed.mat',mouse.name{mouseID});
    OldVar = load(filename); 
    OldVar = OldVar.all_varOutput; 
    end
end
end

