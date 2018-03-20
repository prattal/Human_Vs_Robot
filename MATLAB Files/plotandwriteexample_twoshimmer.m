function void = plotandwriteexample_twoshimmer(comPort1, comPort2, fileName1,fileName2)

%PLOTANDWRITEXAMPLE_TWOSHIMMER - Demonstrate basic features of ShimmerHandleClass
%
%  PLOTANDWRITEEXAMPLE_TWOSHIMMER(COMPORT1, COMPORT2, FILENAME1, FILENAME2).The function 
%  will stream data for two accelerometers and two gyroscopes until it is ended. 
%  The function also writes the data in a tab delimited 
%  format to the files defined in FILENAME1 and FILENAME2.
%  NOTE: This example uses the method 'getdata' which is a more advanced 
%  alternative to the 'getuncalibrateddata' method in the beta release. 
%  The user is advised to use the updated method 'getdata'.  
%
%  SYNOPSIS: plotandwriteexample_twoshimmer(comPort1, comPort2, fileName1, fileName2)
%
%  INPUT: comPort - String value defining the COM port number for Shimmer
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
SensorMacros = SetEnabledSensorsMacrosClass;                               % assign user friendly macros for setenabledsensors
shimmerList = [shimmer1 shimmer2];
firsttime1 = true;
firsttime2 = true;

% Note: these constants are only relevant to this examplescript and are not used
% by the ShimmerHandle Class
%NO_SAMPLES_IN_PLOT = 500;                                                 % Number of samples that will be displayed in the plot at any one time
DELAY_PERIOD = 0.2;                                                        % A delay period of time in seconds between data read operations

%%

if (shimmer1.connect && shimmer2.connect)                                                       % TRUE if the shimmer connects
    
    % Define settings for shimmers
    for S = 1:2
        shimmer = shimmerList(S);  
        shimmer.setsamplingrate(51.2);                                         % Set the shimmer sampling rate to 51.2Hz
        shimmer.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
        shimmer.disableallsensors;                                             % disable all sensors
        shimmer.setenabledsensors(SensorMacros.ACCEL,1,...  % Enable the shimmer accelerometer, gyroscope. To enable any other sensors, add them to this line
            SensorMacros.GYRO,1);    
        shimmer.setaccelrange(0);  
    end

  
          
    if (shimmer1.start && shimmer2.start)                                                     % TRUE if the shimmer starts streaming
        
        while (true)            
                      
            pause(DELAY_PERIOD);                                           % Pause for this period of time on each iteration to allow data to arrive in the buffer
            
            [newData1,signalNameArray,signalFormatArray,signalUnitArray] = shimmer1.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime1==true && isempty(newData1)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    tabbedNextSignalName = [char(44), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,tabbedNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime1=false;
                end
                
                dlmwrite(fileName1, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end

            
            if ~isempty(newData1)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName1, newData1, '-append','precision',16); % Append the new data to the file in a tab delimited format
%Uncomment if you want to plot in real time, but currently causes errors                            
%                 plotData1 = [plotData1; newData1];                            % Update the plotDataBuffer with the new data
%                 numPlotSamples1 = size(plotData1,1);
%                 numSamples1 = numSamples1 + size(newData1,1);
%                 timeStampNew1 = newData1(:,1);                               % get timestamps
%                 timeStamp1 = [timeStamp1; timeStampNew1];
%                 
%                  if numSamples > NO_SAMPLES_IN_PLOT
%                         plotData1 = plotData1(numPlotSamples1-NO_SAMPLES_IN_PLOT+1:end,:);
%                  end
%                  sampleNumber1 = max(numSamples1-NO_SAMPLES_IN_PLOT+1,1):numSamples1;
                 
               
                 chIndex(1) = find(ismember(signalNameArray, 'Time_Stamp'));   % get signal indices
                 if (shimmer1.ShimmerVersion == 3)                              % for Shimmer3
                     chIndex(2) = find(ismember(signalNameArray, 'Low_Noise_Accelerometer_X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Low_Noise_Accelerometer_Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Low_Noise_Accelerometer_Z'));
                 elseif (shimmer1.ShimmerVersion < 3)                           % for Shimmer2/2r
                     chIndex(2) = find(ismember(signalNameArray, 'Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Accelerometer Z'));
                 end
                 chIndex(5) = find(ismember(signalNameArray, 'Gyroscope_X'));
                 chIndex(6) = find(ismember(signalNameArray, 'Gyroscope_Y'));
                 chIndex(7) = find(ismember(signalNameArray, 'Gyroscope_Z'));
%                  chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));   %Unncomment if you want to use the magnetometer
%                  chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
%                  chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
                              
%For plotting in realtime                 
%                 set(0,'CurrentFigure',h.figure1);           
%                 subplot(2,2,1);                                            % Create subplot
%                 signalIndex = chIndex(1);
%                 plot(sampleNumber1, plotData1(:,signalIndex));               % Plot the Time_Stamp data
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
                    tabbedNextSignalName = [char(44), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,tabbedNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime2=false;
                end

                dlmwrite(fileName2, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end
            
            if ~isempty(newData2)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName2, newData2, '-append','precision',16); % Append the new data to the file in a tab delimited format
                            
%                 plotData2 = [plotData2; newData2];                            % Update the plotDataBuffer with the new data
%                 numPlotSamples2 = size(plotData2,1);
%                 numSamples2 = numSamples2 + size(newData2,1);
%                 timeStampNew2 = newData2(:,1);                               % get timestamps
%                 timeStamp2 = [timeStamp2; timeStampNew2];
                
%                  if numSamples2 > NO_SAMPLES_IN_PLOT
%                         plotData2 = plotData2(numPlotSamples2-NO_SAMPLES_IN_PLOT+1:end,:);
%                  end
%                  sampleNumber2 = max(numSamples2-NO_SAMPLES_IN_PLOT+1,1):numSamples2;
                 
               
                 chIndex(1) = find(ismember(signalNameArray, 'Time_Stamp'));   % get signal indices
                 if (shimmer2.ShimmerVersion == 3)                              % for Shimmer3
                     chIndex(2) = find(ismember(signalNameArray, 'Low_Noise_Accelerometer_X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Low_Noise_Accelerometer_Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Low_Noise_Accelerometer_Z'));
                 elseif (shimmer2.ShimmerVersion < 3)                           % for Shimmer2/2r
                     chIndex(2) = find(ismember(signalNameArray, 'Accelerometer X'));
                     chIndex(3) = find(ismember(signalNameArray, 'Accelerometer Y'));
                     chIndex(4) = find(ismember(signalNameArray, 'Accelerometer Z'));
                 end
                 chIndex(5) = find(ismember(signalNameArray, 'Gyroscope_X'));
                 chIndex(6) = find(ismember(signalNameArray, 'Gyroscope_Y'));
                 chIndex(7) = find(ismember(signalNameArray, 'Gyroscope_Z'));
%                  chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));   %Uncomment if you want to use the magnetometer
%                  chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
%                  chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
                              
                 
%                 set(0,'CurrentFigure',h.figure2);           
%                 subplot(2,2,1);                                            % Create subplot
%                 signalIndex = chIndex(1);
%                 plot(sampleNumber2, plotData2(:,signalIndex));               % Plot the Time_Stamp data
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
            
%             elapsedTime = elapsedTime + toc;                               % Stop timer and add to elapsed time
%             tic;                                                           % Start timer           
        end  
        
%         elapsedTime = elapsedTime + toc;                                   % Stop timer
        fprintf('The percentage of received packets: %d \n',shimmer2.getpercentageofpacketsreceived(timeStamp2)); % Detect loss packets
        shimmer1.stop;                                                      % Stop data streaming                                                    
        shimmer2.stop;
    end 
    
    shimmer1.disconnect;                                                    % Disconnect from shimmer
    shimmer2.disconnect;    
end


