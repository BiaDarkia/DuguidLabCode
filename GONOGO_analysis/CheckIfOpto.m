function [Apparatus, Opto] = CheckIfOpto(ABFname, varargin)
% Check if the mouse was trained on boxes (daq) or lever rig (ABF) and
% saves it in day_apparatus folder.
% Check if it's a day in which the optogenetics stimulation was delivered

%% Check apparatus
if isempty(strfind(ABFname,'.daq'))
    % It's an ABF file
    Apparatus = 1; 
else
	% It's a DAQ file
    Apparatus = 0; 
end

%% Check opto
if ~isempty(varargin)
    laser_vec = varargin{1}; 
    if ~isempty(find(laser_vec))
        % The laser was turned on at least once
        Opto = 1;
    else
        Opto = 0;
    end
else
    Opto = 0; 
end

