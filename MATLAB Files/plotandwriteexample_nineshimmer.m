function void = plotandwriteexample_nineshimmer(comPort1, comPort2, comPort3...
    , comPort4, comPort5, comPort6, comPort7, comPort8, comPort9,...
captureDuration, fileName1,fileName2,fileName3, fileName4, fileName5,...
fileName6, fileName7, fileName8, fileName9 )

%PLOTANDWRITEXAMPLE - Demonstrate basic features of ShimmerHandleClass
%
%  PLOTANDWRITEEXAMPLE(COMPORT, CAPTUREDURATION, FILENAME) plots 3 
%  accelerometer signals, 3 gyroscope signals and 3 magnetometer signals,
%  from the Shimmer paired with COMPORT. The function 
%  will stream data for a fixed duration of time defined by the constant 
%  CAPTUREDURATION. The function also writes the data in a tab ddelimited 
%  format to the file defined in FILENAME.
%  NOTE: This example uses the method 'getdata' which is a more advanced 
%  alternative to the 'getuncalibrateddata' method in the beta release. 
%  The user is advised to use the updated method 'getdata'.  
%
%  SYNOPSIS: plotandwriteexample(comPort, captureDuration, fileName)
%
%  INPUT: comPort - String value defining the COM port number for Shimmer
%  INPUT: captureDuration - Numerical value defining the period of time 
%                           (in seconds) for which the function will stream 
%                           data from  the Shimmers.
%  INPUT : fileName - String value defining the name of the file that data 
%                     is written to in a comma delimited format.
%  OUTPUT: none
%
%  EXAMPLE: plotandwriteexample('7', 30, 'testdata.dat')
%
%  See also twoshimmerexample ShimmerHandleClass 


%% definitions

shimmer1 = ShimmerHandleClass(comPort1);                                     % Define shimmer as a ShimmerHandle Class instance with comPort1
shimmer2 = ShimmerHandleClass(comPort2);
shimmer3 = ShimmerHandleClass(comPort3);  
shimmer4 = ShimmerHandleClass(comPort4);  
shimmer5 = ShimmerHandleClass(comPort5); 
shimmer6 = ShimmerHandleClass(comPort6);  
shimmer7 = ShimmerHandleClass(comPort7);
shimmer8 = ShimmerHandleClass(comPort8);  
shimmer9 = ShimmerHandleClass(comPort9);  
SensorMacros = SetEnabledSensorsMacrosClass;                               % assign user friendly macros for setenabledsensors

firsttime1 = true;
firsttime2 = true;
firsttime3 = true;
firsttime4 = true;
firsttime5 = true;
firsttime6 = true;
firsttime7 = true;
firsttime8 = true;
firsttime9 = true;

% Note: these constants are only relevant to this examplescript and are not used
% by the ShimmerHandle Class
NO_SAMPLES_IN_PLOT = 500;                                                  % Number of samples that will be displayed in the plot at any one time
DELAY_PERIOD = 0.2;                                                        % A delay period of time in seconds between data read operations
numSamples1 = 0;
numSamples2 = 0;
numSamples3 = 0;
numSamples4 = 0;
numSamples5 = 0;
numSamples6 = 0;
numSamples7 = 0;
numSamples8 = 0;
numSamples9 = 0;

%%

if (shimmer1.connect && shimmer2.connect && shimmer3.connect &&...
        shimmer4.connect && shimmer5.connect && shimmer6.connect &&...
        shimmer7.connect) %&& shimmer8.connect && shimmer9.connect)           % TRUE if the shimmer connects
    
    % Define settings for shimmer1
    shimmer1.setsamplingrate(51.2);                                         % Set the shimmer sampling rate to 51.2Hz
    shimmer1.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
    shimmer1.disableallsensors;                                             % disable all sensors
    shimmer1.setenabledsensors(SensorMacros.ACCEL,1,SensorMacros.MAG,1,...  % Enable the shimmer accelerometer, magnetometer, gyroscope and battery voltage monitor
        SensorMacros.GYRO,1,SensorMacros.BATT,1);    
    shimmer1.setaccelrange(0);                                              % Set the accelerometer range to 0 (+/- 1.5g) for Shimmer2r
    shimmer1.setbattlimitwarning(3.4);                                      % This will cause the Shimmer LED to turn yellow when the battery voltage drops below 3.4, note that it is only triggered when the battery voltage is being monitored, and after the getdata command is executed to retrieve the battery data 
    
    % Define settings for shimmer2
    shimmer2.setsamplingrate(51.2);                                         % Set the shimmer sampling rate to 51.2Hz
    shimmer2.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
    shimmer2.disableallsensors;                                             % disable all sensors
    shimmer2.setenabledsensors(SensorMacros.ACCEL,1,SensorMacros.MAG,1,...  % Enable the shimmer accelerometer, magnetometer, gyroscope and battery voltage monitor
        SensorMacros.GYRO,1,SensorMacros.BATT,1);    
    shimmer2.setaccelrange(0);                                              % Set the accelerometer range to 0 (+/- 1.5g) for Shimmer2r
    shimmer2.setbattlimitwarning(3.4);                                      % This will cause the Shimmer LED to turn yellow when the battery voltage drops below 3.4, note that it is only triggered when the battery voltage is being monitored, and after the getdata command is executed to retrieve the battery data 
    
  % Define settings for shimmer3
    shimmer3.setsamplingrate(51.2);                                         % Set the shimmer sampling rate to 51.2Hz
    shimmer3.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
    shimmer3.disableallsensors;                                             % disable all sensors
    shimmer3.setenabledsensors(SensorMacros.ACCEL,1,SensorMacros.MAG,1,...  % Enable the shimmer accelerometer, magnetometer, gyroscope and battery voltage monitor
        SensorMacros.GYRO,1,SensorMacros.BATT,1);    
    shimmer3.setaccelrange(0);                                              % Set the accelerometer range to 0 (+/- 1.5g) for Shimmer2r
    shimmer3.setbattlimitwarning(3.4);                                      % This will cause the Shimmer LED to turn yellow when the battery voltage drops below 3.4, note that it is only triggered when the battery voltage is being monitored, and after the getdata command is executed to retrieve the battery data 
    
    % Define settings for shimmer4
    shimmer4.setsamplingrate(51.2);                                         % Set the shimmer sampling rate to 51.2Hz
    shimmer4.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
    shimmer4.disableallsensors;                                             % disable all sensors
    shimmer4.setenabledsensors(SensorMacros.ACCEL,1,SensorMacros.MAG,1,...  % Enable the shimmer accelerometer, magnetometer, gyroscope and battery voltage monitor
        SensorMacros.GYRO,1,SensorMacros.BATT,1);    
    shimmer4.setaccelrange(0);                                              % Set the accelerometer range to 0 (+/- 1.5g) for Shimmer2r
    shimmer4.setbattlimitwarning(3.4);                                      % This will cause the Shimmer LED to turn yellow when the battery voltage drops below 3.4, note that it is only triggered when the battery voltage is being monitored, and after the getdata command is executed to retrieve the battery data 
    
    % Define settings for shimmer5
    shimmer5.setsamplingrate(51.2);                                         % Set the shimmer sampling rate to 51.2Hz
    shimmer5.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
    shimmer5.disableallsensors;                                             % disable all sensors
    shimmer5.setenabledsensors(SensorMacros.ACCEL,1,SensorMacros.MAG,1,...  % Enable the shimmer accelerometer, magnetometer, gyroscope and battery voltage monitor
        SensorMacros.GYRO,1,SensorMacros.BATT,1);    
    shimmer5.setaccelrange(0);                                              % Set the accelerometer range to 0 (+/- 1.5g) for Shimmer2r
    shimmer5.setbattlimitwarning(3.4);                                      % This will cause the Shimmer LED to turn yellow when the battery voltage drops below 3.4, note that it is only triggered when the battery voltage is being monitored, and after the getdata command is executed to retrieve the battery data 
    
    % Define settings for shimmer6
    shimmer6.setsamplingrate(51.2);                                         % Set the shimmer sampling rate to 51.2Hz
    shimmer6.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
    shimmer6.disableallsensors;                                             % disable all sensors
    shimmer6.setenabledsensors(SensorMacros.ACCEL,1,SensorMacros.MAG,1,...  % Enable the shimmer accelerometer, magnetometer, gyroscope and battery voltage monitor
        SensorMacros.GYRO,1,SensorMacros.BATT,1);    
    shimmer6.setaccelrange(0);                                              % Set the accelerometer range to 0 (+/- 1.5g) for Shimmer2r
    shimmer6.setbattlimitwarning(3.4);                                      % This will cause the Shimmer LED to turn yellow when the battery voltage drops below 3.4, note that it is only triggered when the battery voltage is being monitored, and after the getdata command is executed to retrieve the battery data 
    
    % Define settings for shimmer7
    shimmer7.setsamplingrate(51.2);                                         % Set the shimmer sampling rate to 51.2Hz
    shimmer7.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
    shimmer7.disableallsensors;                                             % disable all sensors
    shimmer7.setenabledsensors(SensorMacros.ACCEL,1,SensorMacros.MAG,1,...  % Enable the shimmer accelerometer, magnetometer, gyroscope and battery voltage monitor
        SensorMacros.GYRO,1,SensorMacros.BATT,1);    
    shimmer7.setaccelrange(0);                                              % Set the accelerometer range to 0 (+/- 1.5g) for Shimmer2r
    shimmer7.setbattlimitwarning(3.4);                                      % This will cause the Shimmer LED to turn yellow when the battery voltage drops below 3.4, note that it is only triggered when the battery voltage is being monitored, and after the getdata command is executed to retrieve the battery data 
%     
%     % Define settings for shimmer8
%     shimmer8.setsamplingrate(51.2);                                         % Set the shimmer sampling rate to 51.2Hz
%     shimmer8.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
%     shimmer8.disableallsensors;                                             % disable all sensors
%     shimmer8.setenabledsensors(SensorMacros.ACCEL,1,SensorMacros.MAG,1,...  % Enable the shimmer accelerometer, magnetometer, gyroscope and battery voltage monitor
%         SensorMacros.GYRO,1,SensorMacros.BATT,1);    
%     shimmer8.setaccelrange(0);                                              % Set the accelerometer range to 0 (+/- 1.5g) for Shimmer2r
%     shimmer8.setbattlimitwarning(3.4);                                      % This will cause the Shimmer LED to turn yellow when the battery voltage drops below 3.4, note that it is only triggered when the battery voltage is being monitored, and after the getdata command is executed to retrieve the battery data 
%     
%     % Define settings for shimmer9
%     shimmer9.setsamplingrate(51.2);                                         % Set the shimmer sampling rate to 51.2Hz
%     shimmer9.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
%     shimmer9.disableallsensors;                                             % disable all sensors
%     shimmer9.setenabledsensors(SensorMacros.ACCEL,1,SensorMacros.MAG,1,...  % Enable the shimmer accelerometer, magnetometer, gyroscope and battery voltage monitor
%         SensorMacros.GYRO,1,SensorMacros.BATT,1);    
%     shimmer9.setaccelrange(0);                                              % Set the accelerometer range to 0 (+/- 1.5g) for Shimmer2r
%     shimmer9.setbattlimitwarning(3.4);                                      % This will cause the Shimmer LED to turn yellow when the battery voltage drops below 3.4, note that it is only triggered when the battery voltage is being monitored, and after the getdata command is executed to retrieve the battery data 
%     
    
    if (shimmer1.start && shimmer2.start && shimmer3.start &&...
        shimmer4.start && shimmer5.start && shimmer6.start &&...
        shimmer7.start )%&& shimmer8.start && shimmer9.start)                % TRUE if the shimmer starts streaming

        plotData1 = [];
        plotData2 = [];
        plotData3 = [];
        plotData4 = [];
        plotData5 = [];
        plotData6 = [];
        plotData7 = [];
        plotData8 = [];
        plotData9 = [];
        timeStamp1 = [];
        timeStamp2 = [];
        timeStamp3 = [];
        timeStamp4 = [];
        timeStamp5 = [];
        timeStamp6 = [];
        timeStamp7 = [];
        timeStamp8 = [];
        timeStamp9 = [];
        
        h.figure1=figure('Name','Shimmer 1 signals');                      % Create a handle to figure for plotting data from shimmer
        set(h.figure1, 'Position', [100, 500, 800, 400]);
        
        h.figure2=figure('Name','Shimmer 2 signals');                      % Create a handle to figure for plotting data from shimmer
        set(h.figure2, 'Position', [100, 500, 800, 400]);
        
        elapsedTime = 0;                                                   % Reset to 0    
        tic;                                                               % Start timer
        
        while (elapsedTime < captureDuration)            
                      
            pause(DELAY_PERIOD);                                           % Pause for this period of time on each iteration to allow data to arrive in the buffer
            
            [newData1,signalNameArray,signalFormatArray,signalUnitArray] = shimmer1.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime1==true && isempty(newData1)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    tabbedNextSignalName = [char(9), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,tabbedNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime1=false;
                end

                dlmwrite(fileName1, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end

            
            if ~isempty(newData1)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName1, newData1, '-append', 'delimiter', '\t','precision',16); % Append the new data to the file in a tab delimited format
                            
                plotData1 = [plotData1; newData1];                            % Update the plotDataBuffer with the new data
                numPlotSamples1 = size(plotData1,1);
                numSamples1 = numSamples1 + size(newData1,1);
                timeStampNew1 = newData1(:,1);                               % get timestamps
                timeStamp1 = [timeStamp1; timeStampNew1];
                
                 if numSamples2 > NO_SAMPLES_IN_PLOT
                        plotData1 = plotData1(numPlotSamples1-NO_SAMPLES_IN_PLOT+1:end,:);
                 end
                 sampleNumber1 = max(numSamples1-NO_SAMPLES_IN_PLOT+1,1):numSamples1;
                 
               
                 chIndex(1) = find(ismember(signalNameArray, 'Time Stamp'));   % get signal indices
                 if (shimmer1.ShimmerVersion == 3)                              % for Shimmer3
                     chIndex(2) = find(ismember(signalNameArray, 'Low Noise Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Low Noise Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Low Noise Accelerometer Z'));
                 elseif (shimmer1.ShimmerVersion < 3)                           % for Shimmer2/2r
                     chIndex(2) = find(ismember(signalNameArray, 'Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Accelerometer Z'));
                 end
                 chIndex(5) = find(ismember(signalNameArray, 'Gyroscope X'));
                 chIndex(6) = find(ismember(signalNameArray, 'Gyroscope Y'));
                 chIndex(7) = find(ismember(signalNameArray, 'Gyroscope Z'));
                 chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
                 chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
                 chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
                              
                 
                set(0,'CurrentFigure',h.figure1);           
                subplot(2,2,1);                                            % Create subplot
                signalIndex = chIndex(1);
%                 plot(sampleNumber1, plotData1(:,signalIndex));               % Plot the time stamp data
%                 legend([signalFormatArray{signalIndex} ' ' signalNameArray{signalIndex} ' (' signalUnitArray{signalIndex} ')']);   
%                 xlim([sampleNumber1(1) sampleNumber1(end)]);
% 
%                 subplot(2,2,2);                                            % Create subplot
%                 signalIndex1 = chIndex(2);
%                 signalIndex2 = chIndex(3);
%                 signalIndex3 = chIndex(4);
%                 plot(sampleNumber1, plotData1(:,[signalIndex1 signalIndex2 signalIndex3]));                                 % Plot the accelerometer data
%                 legendName1=[signalFormatArray{signalIndex1} ' ' signalNameArray{signalIndex1} ' (' signalUnitArray{signalIndex1} ')'];  
%                 legendName2=[signalFormatArray{signalIndex2} ' ' signalNameArray{signalIndex2} ' (' signalUnitArray{signalIndex2} ')'];  
%                 legendName3=[signalFormatArray{signalIndex3} ' ' signalNameArray{signalIndex3} ' (' signalUnitArray{signalIndex3} ')'];  
%                 legend(legendName1,legendName2,legendName3); % Add legend to plot
%                 xlim([sampleNumber1(1) sampleNumber1(end)]);
% 
%                 subplot(2,2,3);                                            % Create subplot
%                 signalIndex1 = chIndex(5);
%                 signalIndex2 = chIndex(6);
%                 signalIndex3 = chIndex(7);
%                 plot(sampleNumber1, plotData1(:,[signalIndex1 signalIndex2 signalIndex3]));                                 % Plot the gyroscope data
%                 legendName1=[signalFormatArray{signalIndex1} ' ' signalNameArray{signalIndex1} ' (' signalUnitArray{signalIndex1} ')'];  
%                 legendName2=[signalFormatArray{signalIndex2} ' ' signalNameArray{signalIndex2} ' (' signalUnitArray{signalIndex2} ')'];  
%                 legendName3=[signalFormatArray{signalIndex3} ' ' signalNameArray{signalIndex3} ' (' signalUnitArray{signalIndex3} ')'];  
%                 legend(legendName1,legendName2,legendName3); % Add legend to plot
%                 xlim([sampleNumber1(1) sampleNumber1(end)]);
%                 
%              
%                 subplot(2,2,4);                                            % Create subplot
%                 signalIndex1 = chIndex(8);
%                 signalIndex2 = chIndex(9);
%                 signalIndex3 = chIndex(10);
%                 plot(sampleNumber1, plotData1(:,[signalIndex1 signalIndex2 signalIndex3]));                                 % Plot the magnetometer data
%                 legendName1=[signalFormatArray{signalIndex1} ' ' signalNameArray{signalIndex1} ' (' signalUnitArray{signalIndex1} ')'];  
%                 legendName2=[signalFormatArray{signalIndex2} ' ' signalNameArray{signalIndex2} ' (' signalUnitArray{signalIndex2} ')'];  
%                 legendName3=[signalFormatArray{signalIndex3} ' ' signalNameArray{signalIndex3} ' (' signalUnitArray{signalIndex3} ')'];  
%                 legend(legendName1,legendName2,legendName3); % Add legend to plot
%                 xlim([sampleNumber1(1) sampleNumber1(end)]);
            end
            
            %shimmer2
            
            [newData2,signalNameArray,signalFormatArray,signalUnitArray] = shimmer2.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime2==true && isempty(newData2)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    tabbedNextSignalName = [char(9), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,tabbedNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime2=false;
                end

                dlmwrite(fileName2, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end
            
            if ~isempty(newData2)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName2, newData2, '-append', 'delimiter', '\t','precision',16); % Append the new data to the file in a tab delimited format
                            
                plotData2 = [plotData2; newData2];                            % Update the plotDataBuffer with the new data
                numPlotSamples2 = size(plotData2,1);
                numSamples2 = numSamples2 + size(newData2,1);
                timeStampNew2 = newData2(:,1);                               % get timestamps
                timeStamp2 = [timeStamp2; timeStampNew2];
                
                 if numSamples2 > NO_SAMPLES_IN_PLOT
                        plotData2 = plotData2(numPlotSamples2-NO_SAMPLES_IN_PLOT+1:end,:);
                 end
                 sampleNumber2 = max(numSamples2-NO_SAMPLES_IN_PLOT+1,1):numSamples2;
                 
               
                 chIndex(1) = find(ismember(signalNameArray, 'Time Stamp'));   % get signal indices
                 if (shimmer2.ShimmerVersion == 3)                              % for Shimmer3
                     chIndex(2) = find(ismember(signalNameArray, 'Low Noise Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Low Noise Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Low Noise Accelerometer Z'));
                 elseif (shimmer2.ShimmerVersion < 3)                           % for Shimmer2/2r
                     chIndex(2) = find(ismember(signalNameArray, 'Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Accelerometer Z'));
                 end
                 chIndex(5) = find(ismember(signalNameArray, 'Gyroscope X'));
                 chIndex(6) = find(ismember(signalNameArray, 'Gyroscope Y'));
                 chIndex(7) = find(ismember(signalNameArray, 'Gyroscope Z'));
                 chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
                 chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
                 chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
                              
                 
                set(0,'CurrentFigure',h.figure2);           
                subplot(2,2,1);                                            % Create subplot
                signalIndex = chIndex(1);
                plot(sampleNumber2, plotData2(:,signalIndex));               % Plot the time stamp data
                legend([signalFormatArray{signalIndex} ' ' signalNameArray{signalIndex} ' (' signalUnitArray{signalIndex} ')']);   
                xlim([sampleNumber2(1) sampleNumber2(end)]);

                subplot(2,2,2);                                            % Create subplot
                signalIndex1 = chIndex(2);
                signalIndex2 = chIndex(3);
                signalIndex3 = chIndex(4);
                plot(sampleNumber2, plotData2(:,[signalIndex1 signalIndex2 signalIndex3]));                                 % Plot the accelerometer data
                legendName1=[signalFormatArray{signalIndex1} ' ' signalNameArray{signalIndex1} ' (' signalUnitArray{signalIndex1} ')'];  
                legendName2=[signalFormatArray{signalIndex2} ' ' signalNameArray{signalIndex2} ' (' signalUnitArray{signalIndex2} ')'];  
                legendName3=[signalFormatArray{signalIndex3} ' ' signalNameArray{signalIndex3} ' (' signalUnitArray{signalIndex3} ')'];  
                legend(legendName1,legendName2,legendName3); % Add legend to plot
                xlim([sampleNumber2(1) sampleNumber2(end)]);

                subplot(2,2,3);                                            % Create subplot
                signalIndex1 = chIndex(5);
                signalIndex2 = chIndex(6);
                signalIndex3 = chIndex(7);
                plot(sampleNumber2, plotData2(:,[signalIndex1 signalIndex2 signalIndex3]));                                 % Plot the gyroscope data
                legendName1=[signalFormatArray{signalIndex1} ' ' signalNameArray{signalIndex1} ' (' signalUnitArray{signalIndex1} ')'];  
                legendName2=[signalFormatArray{signalIndex2} ' ' signalNameArray{signalIndex2} ' (' signalUnitArray{signalIndex2} ')'];  
                legendName3=[signalFormatArray{signalIndex3} ' ' signalNameArray{signalIndex3} ' (' signalUnitArray{signalIndex3} ')'];  
                legend(legendName1,legendName2,legendName3); % Add legend to plot
                xlim([sampleNumber2(1) sampleNumber2(end)]);
                
             
                subplot(2,2,4);                                            % Create subplot
                signalIndex1 = chIndex(8);
                signalIndex2 = chIndex(9);
                signalIndex3 = chIndex(10);
                plot(sampleNumber2, plotData2(:,[signalIndex1 signalIndex2 signalIndex3]));                                 % Plot the magnetometer data
                legendName1=[signalFormatArray{signalIndex1} ' ' signalNameArray{signalIndex1} ' (' signalUnitArray{signalIndex1} ')'];  
                legendName2=[signalFormatArray{signalIndex2} ' ' signalNameArray{signalIndex2} ' (' signalUnitArray{signalIndex2} ')'];  
                legendName3=[signalFormatArray{signalIndex3} ' ' signalNameArray{signalIndex3} ' (' signalUnitArray{signalIndex3} ')'];  
                legend(legendName1,legendName2,legendName3); % Add legend to plot
                xlim([sampleNumber2(1) sampleNumber2(end)]);
            end
            
            %shimmer3
            
            [newData3,signalNameArray,signalFormatArray,signalUnitArray] = shimmer3.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime3==true && isempty(newData3)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    tabbedNextSignalName = [char(9), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,tabbedNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime3=false;
                end

                dlmwrite(fileName3, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end
            
            if ~isempty(newData3)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName3, newData3, '-append', 'delimiter', '\t','precision',16); % Append the new data to the file in a tab delimited format
                            
                plotData3 = [plotData3; newData3];                            % Update the plotDataBuffer with the new data
                numPlotSamples3 = size(plotData3,1);
                numSamples3 = numSamples3 + size(newData3,1);
                timeStampNew3 = newData3(:,1);                               % get timestamps
                timeStamp3 = [timeStamp3; timeStampNew3];
                
                 if numSamples2 > NO_SAMPLES_IN_PLOT
                        plotData3 = plotData3(numPlotSamples3-NO_SAMPLES_IN_PLOT+1:end,:);
                 end
                 sampleNumber3 = max(numSamples3-NO_SAMPLES_IN_PLOT+1,1):numSamples3;
                 
               
                 chIndex(1) = find(ismember(signalNameArray, 'Time Stamp'));   % get signal indices
                 if (shimmer3.ShimmerVersion == 3)                              % for Shimmer3
                     chIndex(2) = find(ismember(signalNameArray, 'Low Noise Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Low Noise Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Low Noise Accelerometer Z'));
                 elseif (shimmer3.ShimmerVersion < 3)                           % for Shimmer2/2r
                     chIndex(2) = find(ismember(signalNameArray, 'Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Accelerometer Z'));
                 end
                 chIndex(5) = find(ismember(signalNameArray, 'Gyroscope X'));
                 chIndex(6) = find(ismember(signalNameArray, 'Gyroscope Y'));
                 chIndex(7) = find(ismember(signalNameArray, 'Gyroscope Z'));
                 chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
                 chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
                 chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
                              
                 
%                 set(0,'CurrentFigure',h.figure2);           
%                 subplot(2,2,1);                                            % Create subplot
%                 signalIndex = chIndex(1);
%                 plot(sampleNumber2, plotData2(:,signalIndex));               % Plot the time stamp data
%                 legend([signalFormatArray{signalIndex} ' ' signalNameArray{signalIndex} ' (' signalUnitArray{signalIndex} ')']);   
%                 xlim([sampleNumber2(1) sampleNumber2(end)]);
% 
%                 subplot(2,2,2);                                            % Create subplot
%                 signalIndex1 = chIndex(2);
%                 signalIndex2 = chIndex(3);
%                 signalIndex3 = chIndex(4);
%                 plot(sampleNumber2, plotData2(:,[signalIndex1 signalIndex2 signalIndex3]));                                 % Plot the accelerometer data
%                 legendName1=[signalFormatArray{signalIndex1} ' ' signalNameArray{signalIndex1} ' (' signalUnitArray{signalIndex1} ')'];  
%                 legendName2=[signalFormatArray{signalIndex2} ' ' signalNameArray{signalIndex2} ' (' signalUnitArray{signalIndex2} ')'];  
%                 legendName3=[signalFormatArray{signalIndex3} ' ' signalNameArray{signalIndex3} ' (' signalUnitArray{signalIndex3} ')'];  
%                 legend(legendName1,legendName2,legendName3); % Add legend to plot
%                 xlim([sampleNumber2(1) sampleNumber2(end)]);
% 
%                 subplot(2,2,3);                                            % Create subplot
%                 signalIndex1 = chIndex(5);
%                 signalIndex2 = chIndex(6);
%                 signalIndex3 = chIndex(7);
%                 plot(sampleNumber2, plotData2(:,[signalIndex1 signalIndex2 signalIndex3]));                                 % Plot the gyroscope data
%                 legendName1=[signalFormatArray{signalIndex1} ' ' signalNameArray{signalIndex1} ' (' signalUnitArray{signalIndex1} ')'];  
%                 legendName2=[signalFormatArray{signalIndex2} ' ' signalNameArray{signalIndex2} ' (' signalUnitArray{signalIndex2} ')'];  
%                 legendName3=[signalFormatArray{signalIndex3} ' ' signalNameArray{signalIndex3} ' (' signalUnitArray{signalIndex3} ')'];  
%                 legend(legendName1,legendName2,legendName3); % Add legend to plot
%                 xlim([sampleNumber2(1) sampleNumber2(end)]);
%                 
%              
%                 subplot(2,2,4);                                            % Create subplot
%                 signalIndex1 = chIndex(8);
%                 signalIndex2 = chIndex(9);
%                 signalIndex3 = chIndex(10);
%                 plot(sampleNumber2, plotData2(:,[signalIndex1 signalIndex2 signalIndex3]));                                 % Plot the magnetometer data
%                 legendName1=[signalFormatArray{signalIndex1} ' ' signalNameArray{signalIndex1} ' (' signalUnitArray{signalIndex1} ')'];  
%                 legendName2=[signalFormatArray{signalIndex2} ' ' signalNameArray{signalIndex2} ' (' signalUnitArray{signalIndex2} ')'];  
%                 legendName3=[signalFormatArray{signalIndex3} ' ' signalNameArray{signalIndex3} ' (' signalUnitArray{signalIndex3} ')'];  
%                 legend(legendName1,legendName2,legendName3); % Add legend to plot
%                 xlim([sampleNumber2(1) sampleNumber2(end)]);
            end
            
            [newData4,signalNameArray,signalFormatArray,signalUnitArray] = shimmer4.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime4==true && isempty(newData4)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    tabbedNextSignalName = [char(9), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,tabbedNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime4=false;
                end

                dlmwrite(fileName4, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end

            
            if ~isempty(newData4)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName4, newData4, '-append', 'delimiter', '\t','precision',16); % Append the new data to the file in a tab delimited format
                            
                plotData4 = [plotData4; newData4];                            % Update the plotDataBuffer with the new data
                numPlotSamples4 = size(plotData4,1);
                numSamples4 = numSamples4 + size(newData4,1);
                timeStampNew4 = newData4(:,1);                               % get timestamps
                timeStamp4 = [timeStamp4; timeStampNew4];
                
                 if numSamples4 > NO_SAMPLES_IN_PLOT
                        plotData4 = plotData4(numPlotSamples4-NO_SAMPLES_IN_PLOT+1:end,:);
                 end
                 sampleNumber4 = max(numSamples4-NO_SAMPLES_IN_PLOT+1,1):numSamples4;
                 
               
                 chIndex(1) = find(ismember(signalNameArray, 'Time Stamp'));   % get signal indices
                 if (shimmer4.ShimmerVersion == 3)                              % for Shimmer3
                     chIndex(2) = find(ismember(signalNameArray, 'Low Noise Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Low Noise Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Low Noise Accelerometer Z'));
                 elseif (shimmer4.ShimmerVersion < 3)                           % for Shimmer2/2r
                     chIndex(2) = find(ismember(signalNameArray, 'Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Accelerometer Z'));
                 end
                 chIndex(5) = find(ismember(signalNameArray, 'Gyroscope X'));
                 chIndex(6) = find(ismember(signalNameArray, 'Gyroscope Y'));
                 chIndex(7) = find(ismember(signalNameArray, 'Gyroscope Z'));
                 chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
                 chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
                 chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
                              
            end
            
            %shimmer5
            
            [newData5,signalNameArray,signalFormatArray,signalUnitArray] = shimmer5.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime5==true && isempty(newData5)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    tabbedNextSignalName = [char(9), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,tabbedNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime5=false;
                end

                dlmwrite(fileName5, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end

            
            if ~isempty(newData5)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName5, newData5, '-append', 'delimiter', '\t','precision',16); % Append the new data to the file in a tab delimited format
                            
                plotData5 = [plotData5; newData5];                            % Update the plotDataBuffer with the new data
                numPlotSamples5 = size(plotData5,1);
                numSamples5 = numSamples5 + size(newData5,1);
                timeStampNew5 = newData5(:,1);                               % get timestamps
                timeStamp5 = [timeStamp5; timeStampNew5];
                
                 if numSamples5 > NO_SAMPLES_IN_PLOT
                        plotData5 = plotData5(numPlotSamples5-NO_SAMPLES_IN_PLOT+1:end,:);
                 end
                 sampleNumber5 = max(numSamples5-NO_SAMPLES_IN_PLOT+1,1):numSamples5;
                 
               
                 chIndex(1) = find(ismember(signalNameArray, 'Time Stamp'));   % get signal indices
                 if (shimmer5.ShimmerVersion == 3)                              % for Shimmer3
                     chIndex(2) = find(ismember(signalNameArray, 'Low Noise Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Low Noise Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Low Noise Accelerometer Z'));
                 elseif (shimmer5.ShimmerVersion < 3)                           % for Shimmer2/2r
                     chIndex(2) = find(ismember(signalNameArray, 'Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Accelerometer Z'));
                 end
                 chIndex(5) = find(ismember(signalNameArray, 'Gyroscope X'));
                 chIndex(6) = find(ismember(signalNameArray, 'Gyroscope Y'));
                 chIndex(7) = find(ismember(signalNameArray, 'Gyroscope Z'));
                 chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
                 chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
                 chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
                 
            end
            
            %shimmer6
            
            [newData6,signalNameArray,signalFormatArray,signalUnitArray] = shimmer6.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime6==true && isempty(newData6)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    tabbedNextSignalName = [char(9), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,tabbedNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime6=false;
                end

                dlmwrite(fileName6, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end

            
            if ~isempty(newData6)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName6, newData6, '-append', 'delimiter', '\t','precision',16); % Append the new data to the file in a tab delimited format
                            
                plotData6 = [plotData6; newData6];                            % Update the plotDataBuffer with the new data
                numPlotSamples6 = size(plotData6,1);
                numSamples6 = numSamples6 + size(newData6,1);
                timeStampNew6 = newData6(:,1);                               % get timestamps
                timeStamp6 = [timeStamp6; timeStampNew6];
                
                 if numSamples6 > NO_SAMPLES_IN_PLOT
                        plotData6 = plotData6(numPlotSamples6-NO_SAMPLES_IN_PLOT+1:end,:);
                 end
                 sampleNumber6 = max(numSamples6-NO_SAMPLES_IN_PLOT+1,1):numSamples6;
                 
               
                 chIndex(1) = find(ismember(signalNameArray, 'Time Stamp'));   % get signal indices
                 if (shimmer6.ShimmerVersion == 3)                              % for Shimmer3
                     chIndex(2) = find(ismember(signalNameArray, 'Low Noise Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Low Noise Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Low Noise Accelerometer Z'));
                 elseif (shimmer6.ShimmerVersion < 3)                           % for Shimmer2/2r
                     chIndex(2) = find(ismember(signalNameArray, 'Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Accelerometer Z'));
                 end
                 chIndex(5) = find(ismember(signalNameArray, 'Gyroscope X'));
                 chIndex(6) = find(ismember(signalNameArray, 'Gyroscope Y'));
                 chIndex(7) = find(ismember(signalNameArray, 'Gyroscope Z'));
                 chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
                 chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
                 chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
            end
            
            %shimmer7
            
            [newData7,signalNameArray,signalFormatArray,signalUnitArray] = shimmer7.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime7==true && isempty(newData7)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    tabbedNextSignalName = [char(9), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,tabbedNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime7=false;
                end

                dlmwrite(fileName7, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end

            
            if ~isempty(newData7)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName7, newData7, '-append', 'delimiter', '\t','precision',16); % Append the new data to the file in a tab delimited format
                            
                plotData7 = [plotData7; newData7];                            % Update the plotDataBuffer with the new data
                numPlotSamples7 = size(plotData7,1);
                numSamples7 = numSamples7 + size(newData7,1);
                timeStampNew7 = newData7(:,1);                               % get timestamps
                timeStamp7 = [timeStamp7; timeStampNew7];
                
                 if numSamples7 > NO_SAMPLES_IN_PLOT
                        plotData7 = plotData7(numPlotSamples7-NO_SAMPLES_IN_PLOT+1:end,:);
                 end
                 sampleNumber7 = max(numSamples7-NO_SAMPLES_IN_PLOT+1,1):numSamples7;
                 
               
                 chIndex(1) = find(ismember(signalNameArray, 'Time Stamp'));   % get signal indices
                 if (shimmer7.ShimmerVersion == 3)                              % for Shimmer3
                     chIndex(2) = find(ismember(signalNameArray, 'Low Noise Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Low Noise Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Low Noise Accelerometer Z'));
                 elseif (shimmer7.ShimmerVersion < 3)                           % for Shimmer2/2r
                     chIndex(2) = find(ismember(signalNameArray, 'Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Accelerometer Z'));
                 end
                 chIndex(5) = find(ismember(signalNameArray, 'Gyroscope X'));
                 chIndex(6) = find(ismember(signalNameArray, 'Gyroscope Y'));
                 chIndex(7) = find(ismember(signalNameArray, 'Gyroscope Z'));
                 chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
                 chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
                 chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
                 
            end
            
            %%shimmer8
%             
%             [newData8,signalNameArray,signalFormatArray,signalUnitArray] = shimmer8.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
%                         
% 
% 
%             if (firsttime8==true && isempty(newData8)~=1) 
%                 signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
%                 for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
%                     tabbedNextSignalName = [char(9), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
%                     signalNamesString = strcat(signalNamesString,tabbedNextSignalName);                   % Concatenate signal names delimited by a tab.
%                  
%                     firsttime8=false;
%                 end
% 
%                 dlmwrite(fileName8, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file
% 
%             end
% 
%             
%             if ~isempty(newData8)                                           % TRUE if new data has arrived
%                                 
%                 dlmwrite(fileName8, newData8, '-append', 'delimiter', '\t','precision',16); % Append the new data to the file in a tab delimited format
%                             
%                 plotData8 = [plotData8; newData8];                            % Update the plotDataBuffer with the new data
%                 numPlotSamples8 = size(plotData8,1);
%                 numSamples8 = numSamples8 + size(newData8,1);
%                 timeStampNew8 = newData8(:,1);                               % get timestamps
%                 timeStamp8 = [timeStamp8; timeStampNew8];
%                 
%                  if numSamples8 > NO_SAMPLES_IN_PLOT
%                         plotData8 = plotData8(numPlotSamples8-NO_SAMPLES_IN_PLOT+1:end,:);
%                  end
%                  sampleNumber8 = max(numSamples8-NO_SAMPLES_IN_PLOT+1,1):numSamples8;
%                  
%                
%                  chIndex(1) = find(ismember(signalNameArray, 'Time Stamp'));   % get signal indices
%                  if (shimmer8.ShimmerVersion == 3)                              % for Shimmer3
%                      chIndex(2) = find(ismember(signalNameArray, 'Low Noise Accelerometer X'));
%                      chIndex(3) = find(ismember(signalNameArray, 'Low Noise Accelerometer Y'));
%                      chIndex(4) = find(ismember(signalNameArray, 'Low Noise Accelerometer Z'));
%                  elseif (shimmer8.ShimmerVersion < 3)                           % for Shimmer2/2r
%                      chIndex(2) = find(ismember(signalNameArray, 'Accelerometer X'));
%                      chIndex(3) = find(ismember(signalNameArray, 'Accelerometer Y'));
%                      chIndex(4) = find(ismember(signalNameArray, 'Accelerometer Z'));
%                  end
%                  chIndex(5) = find(ismember(signalNameArray, 'Gyroscope X'));
%                  chIndex(6) = find(ismember(signalNameArray, 'Gyroscope Y'));
%                  chIndex(7) = find(ismember(signalNameArray, 'Gyroscope Z'));
%                  chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
%                  chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
%                  chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
%                  
%             end
%             
%             %%shimmer9
%             
%             [newData9,signalNameArray,signalFormatArray,signalUnitArray] = shimmer9.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
%                         
% 
% 
%             if (firsttime9==true && isempty(newData9)~=1) 
%                 signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
%                 for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
%                     tabbedNextSignalName = [char(9), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
%                     signalNamesString = strcat(signalNamesString,tabbedNextSignalName);                   % Concatenate signal names delimited by a tab.
%                  
%                     firsttime9=false;
%                 end
% 
%                 dlmwrite(fileName9, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file
% 
%             end
% 
%             
%             if ~isempty(newData9)                                           % TRUE if new data has arrived
%                                 
%                 dlmwrite(fileName9, newData9, '-append', 'delimiter', '\t','precision',16); % Append the new data to the file in a tab delimited format
%                             
%                 plotData9 = [plotData9; newData9];                            % Update the plotDataBuffer with the new data
%                 numPlotSamples9 = size(plotData9,1);
%                 numSamples9 = numSamples9 + size(newData9,1);
%                 timeStampNew9 = newData9(:,1);                               % get timestamps
%                 timeStamp9 = [timeStamp9; timeStampNew9];
%                 
%                  if numSamples9 > NO_SAMPLES_IN_PLOT
%                         plotData9 = plotData9(numPlotSamples9-NO_SAMPLES_IN_PLOT+1:end,:);
%                  end
%                  sampleNumber9 = max(numSamples9-NO_SAMPLES_IN_PLOT+1,1):numSamples9;
%                  
%                
%                  chIndex(1) = find(ismember(signalNameArray, 'Time Stamp'));   % get signal indices
%                  if (shimmer9.ShimmerVersion == 3)                              % for Shimmer3
%                      chIndex(2) = find(ismember(signalNameArray, 'Low Noise Accelerometer X'));
%                      chIndex(3) = find(ismember(signalNameArray, 'Low Noise Accelerometer Y'));
%                      chIndex(4) = find(ismember(signalNameArray, 'Low Noise Accelerometer Z'));
%                  elseif (shimmer.ShimmerVersion < 3)                           % for Shimmer2/2r
%                      chIndex(2) = find(ismember(signalNameArray, 'Accelerometer X'));
%                      chIndex(3) = find(ismember(signalNameArray, 'Accelerometer Y'));
%                      chIndex(4) = find(ismember(signalNameArray, 'Accelerometer Z'));
%                  end
%                  chIndex(5) = find(ismember(signalNameArray, 'Gyroscope X'));
%                  chIndex(6) = find(ismember(signalNameArray, 'Gyroscope Y'));
%                  chIndex(7) = find(ismember(signalNameArray, 'Gyroscope Z'));
%                  chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
%                  chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
%                  chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
%             end
            
            elapsedTime = elapsedTime + toc;                               % Stop timer and add to elapsed time
            tic;                                                           % Start timer           
            
        end  
        
        elapsedTime = elapsedTime + toc;                                   % Stop timer
        fprintf('The percentage of received packets: %d \n',shimmer1.getpercentageofpacketsreceived(timeStamp2)); % Detect loss packets
        shimmer1.stop;                                                      % Stop data streaming                                                    
        shimmer2.stop;
        shimmer3.stop;
        shimmer4.stop;
        shimmer5.stop;
        shimmer6.stop;
        shimmer7.stop;
        %shimmer8.stop;
        %shimmer9.stop;
    end 
    
    shimmer1.disconnect;                                                    % Disconnect from shimmer
    shimmer2.disconnect; 
    shimmer3.disconnect;
    shimmer4.disconnect;
    shimmer5.disconnect;
    shimmer6.disconnect;
    shimmer7.disconnect;
    %shimmer8.disconnect;
    %shimmer9.disconnect;
end


