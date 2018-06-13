function [ num_days_analysed ] = ChechAnalysedDays( checkname )
% This function checks the number of analysed days to avoid re-analysing
% them
loadVar = load(checkname); 
num_days_analysed = length(loadVar.all_var.training_length); 

end

