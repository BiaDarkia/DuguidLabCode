function saveAllVar_Gonogo(mouseID, mouse, all_var,AnalysedDir)
% saveAllVar saves all variables (all_var) generated in the lever training
% analysis script

MetaPathList

cd(AnalysedDir);

if ~isempty(mouse.name{mouseID})
    
    if ~exist('allfiles','var')
        if strcmp('Y','Y')
            filename=sprintf('%s_analysed.mat',mouse.name{mouseID});
            summaryname = sprintf('%s_analysed_summary.mat',mouse.name{mouseID});
            %all_varname=strcat(allVarNamePathfolder,filename);
            
            create_allvar_summary
            
            save(filename,'all_var');
            save(summaryname,'summary_allvar');

            fprintf('Saving all final variables to\n%s\n',filename);
        end
        
    elseif allfiles==0
        
        reply = input('Do you want to save the data (overwriting the previous ones!)? [Y/N]: ', 's');
        
        if isempty(reply)
            reply = 'N';
        end
        
        if strcmp('Y',reply)
            filename=sprintf('%s_analysed.mat',mouse.name{mouseID});
            all_varname=strcat(allVarNamePathfolder,filename);
            save(all_varname,'all_var');
            fprintf('Saving all final variables to\n%s\n',all_varname);
        end
        
    elseif allfiles==1
        
        filename=sprintf('%s_analysed.mat',mouse.name{mouseID});
        all_varname=strcat(allVarNamePathfolder,filename);
        save(all_varname,'all_var');
        fprintf('Saving all final variables to\n%s\n',all_varname);
        
    end
end
end

