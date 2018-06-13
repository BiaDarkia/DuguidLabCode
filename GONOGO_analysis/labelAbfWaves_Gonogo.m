function [sensor_trigger_vec, sensor_reward_vec, reward_signal_vec, reset_vec, tone_vec, varargout] = ...
    labelAbfWaves_Gonogo( ABF, sensor_th, tone_th, ABFname)


% Check if we are loading an ABF or a DAQ file

if ~isempty(strfind(ABFname,'.daq'))
    % It's a daq file
     LabelDAQfile();
else
    % It's an ABF file
    LabelABFfile();
end


    function LabelDAQfile
        % labelDaqWaves appropriately labels waves of the DAQ and creates the
        % vectors that are used for the analysis
        
        % Rename columns of data appropriately
        sensor_reward       = ABF(:,2);
        sensor_trigger      = ABF(:,1);
        signal_reward       = ABF(:,3);
        signal_reset        = ABF(:,4);
        signal_tone         = ABF(:,5);
        
        % Sometimes the light wave might be missing because not recorded during
        % training
        if size(ABF,2) ==   6
            signal_light        = ABF(:,6);
            light_vec           = (signal_light > sensor_th);    % Time points at which the light is       ON
        else
            light_vec = zeros(1,length(ABF));
        end
        varargout{1} = light_vec;
        
        % Create vectors
        sensor_trigger_vec  = (sensor_trigger > sensor_th);  % Time points at which trigger sensor is  HIGH
        sensor_reward_vec   = (sensor_reward > sensor_th);   % Time points at which reward sensor is   HIGH
        reward_signal_vec   = (signal_reward > sensor_th);   % Time points at which reward signal is   HIGH
        reset_vec           = (signal_reset > sensor_th);    % Time points at which  the reset signal is HIGH
        tone_vec            = (abs(signal_tone) > tone_th);  % Time points at which tone is            ON
        
        
    end

    function LabelABFfile
        % labelDaqWaves appropriately labels waves of the DAQ and creates the
        % vectors that are used for the analysis
        
        % Check how many channels are in the ABF
        if size(ABF,2)== 7
            % Rename columns of data appropriately
            sensor_reward       = ABF(:,1);
            sensor_trigger      = ABF(:,2);
            signal_reward       = ABF(:,3);
            signal_reset        = ABF(:,4);
            signal_tone         = ABF(:,5);
            signal_shutter      = ABF(:,6);
            signal_laser        = ABF(:,7);

            % Create vectors
            sensor_trigger_vec  = (sensor_trigger > sensor_th);  % Time points at which trigger sensor is  HIGH
            sensor_reward_vec   = (sensor_reward > sensor_th);   % Time points at which reward sensor is   HIGH
            reward_signal_vec   = (signal_reward > sensor_th);   % Time points at which reward signal is   HIGH
            reset_vec           = (signal_reset > sensor_th);    % Time points at which  the reset signal is HIGH
            tone_vec            = (abs(signal_tone) > tone_th);  % Time points at which tone is            ON
            shutter_vec         = (signal_shutter > sensor_th);  % Time points at which shutter is         ??
            laser_vec           = (signal_laser > sensor_th);  % Time points at which laser is             ON
            
            varargout{1} = shutter_vec;
            varargout{2} = laser_vec;
        
        else
            try
                sensor_reward       = ABF(:,1);
                sensor_trigger      = ABF(:,2);
                signal_reward       = ABF(:,3);
                signal_reset        = ABF(:,4);
                signal_tone         = ABF(:,5);
                
                sensor_trigger_vec  = (sensor_trigger > sensor_th);  % Time points at which trigger sensor is  HIGH
                sensor_reward_vec   = (sensor_reward > sensor_th);   % Time points at which reward sensor is   HIGH
                reward_signal_vec   = (signal_reward > sensor_th);   % Time points at which reward signal is   HIGH
                reset_vec           = (signal_reset > sensor_th);    % Time points at which  the reset signal is HIGH
                tone_vec            = (abs(signal_tone) > tone_th);  % Time points at which tone is            ON
            catch
                error('The ABF file format is not recognised, please contact federicoclaudi@gmail.com'); 
            end
        end
        
        
        
        
    end


end

