function [ABF] = loadAbfData(filename)
% loadAbfData_multi loads multiple ABFs as one data file data for a particular training session appropriately
ABF = [];

if strcmp(filename(regexp(filename,'.mat')),'.')==1 % Distinguish .mat data (typically concatenated) from .daq and raw abf
    fprintf('** normal load \n opening %s \n',filename)
    ABF=load(filename);
    ABF=ABF.Data;
elseif strcmp(filename(regexp(filename,'.daq')),'.')==1 % Distinguish .daq (data from training boxes) from raw abf
    fprintf('** normal load \n opening %s \n',filename)
    ABF=daqread(filename);
else
    ABF=abfLoad2(filename); % Load raw abf
end

end


