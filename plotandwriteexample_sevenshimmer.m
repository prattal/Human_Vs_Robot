function void = plotandwriteexample_sevenshimmer(comPort1, comPort2, comPort3...
    , comPort4, comPort5, comPort6, comPort7,...
fileName1,fileName2,fileName3, fileName4, fileName5,...
fileName6, fileName7)

%PLOTANDWRITEXAMPLE_SEVENSHIMMER - Demonstrate basic features of ShimmerHandleClass
%
%  PLOTANDWRITEEXAMPLE_SEVENSHIMMER(COMPORT1,COMPORT2, COMPORT3, COMPORT4,
%  COMPORT5, COMPORT6, COMPORT7, FILENAME1,FILENAME2, FILENAME3, FILENAME,
%  FILENAME5, FILENAME6, FILENAME7) The function 
%  will stream data for the seven shimmers connected to the user procvided 
%  comports. The function also writes the data in a tab ddelimited 
%  format to the files defined by the 7 FILENAME variables.
%  NOTE: This example uses the method 'getdata' which is a more advanced 
%  alternative to the 'getuncalibrateddata' method in the beta release. 
%  The user is advised to use the updated method 'getdata'.  
%
%  SYNOPSIS: plotandwriteexample(comPort(1-7), fileName(1-7))
%
%  INPUT: comPort - String value defining the COM port number for Shimmer
%
%  INPUT : fileName - String value defining the name of the file that data 
%                     is written to in a comma delimited format.
%  OUTPUT: none
%
%  EXAMPLE: plotandwriteexample('1','2','3','4','5','6','7', '1.dat,'2.dat'
%  ,'3.dat','4.dat','5.dat','6.dat','7.dat')
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
SensorMacros = SetEnabledSensorsMacrosClass;                               % assign user friendly macros for setenabledsensors
shimmerList = [shimmer1 shimmer2 shimmer3 shimmer4 shimmer5 shimmer6...
    shimmer7];
firsttime1 = true;
firsttime2 = true;
firsttime3 = true;
firsttime4 = true;
firsttime5 = true;
firsttime6 = true;
firsttime7 = true;

%variables for tone
amp=10;
fs=20500;  % sampling frequency
duration1=.05;
duration2 = .8;
freq1=3000;
freq2 = 2000;
values1=0:1/fs:duration1;
values2 =0:1/fs:duration2;
a1=amp*sin(2*pi* freq1*values1);
a2=amp*sin(2*pi* freq2*values2);


% Note: these constants are only relevant to this examplescript and are not used
% by the ShimmerHandle Class
% NO_SAMPLES_IN_PLOT = 500;                                                  % Number of samples that will be displayed in the plot at any one time
DELAY_PERIOD = 0.2;                                                        % A delay period of time in seconds between data read operations

%%

if (shimmer1.connect && shimmer2.connect && shimmer3.connect &&...
        shimmer4.connect && shimmer5.connect && shimmer6.connect &&...
        shimmer7.connect) %&& shimmer8.connect && shimmer9.connect)           % TRUE if the shimmer connects
    
    % Define settings for shimmers
    i = 6;
    for S = 1:7
        shimmer = shimmerList(S);
        shimmer.setsamplingrate(102.4);                                      %Set the shimmer sampling rate to 51.2Hz
        shimmer.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
        shimmer.disableallsensors;                                             % disable all sensors
        shimmer.setenabledsensors(SensorMacros.ACCEL,1,...  % Enable the shimmer accelerometer, and gyroscope Enable magnetometer and battery voltage monitor here if needed
            SensorMacros.GYRO,1);    
        shimmer.setaccelrange(0);                                              % Set the accelerometer range to 0 (+/- 1.5g) for Shimmer2r
%       shimmer.setbattlimitwarning(3.4);                                      % This will cause the Shimmer LED to turn yellow when the battery voltage drops below 3.4, note that it is only triggered when the battery voltage is being monitored, and after the getdata command is executed to retrieve the battery data 
        if i==0
            sound(a1);
                                                      %Play final tone
        else
            disp(i)                                                         %Display current number in countdown
            sound(a1);                                                      %Play countdown tone
        end
        i = i-1;
       
    end
    
    if (shimmer1.start && shimmer2.start && shimmer3.start &&...
        shimmer4.start && shimmer5.start && shimmer6.start &&...
        shimmer7.start )%&& shimmer8.start && shimmer9.start)                % TRUE if the shimmer starts streaming
%Uncomment if you want to live plot, but currently causes problems
%         plotData1 = [];
%         plotData2 = [];
%         plotData3 = [];
%         plotData4 = [];
%         plotData5 = [];
%         plotData6 = [];
%         plotData7 = [];
%         %plotData8 = [];
%         %plotData9 = [];
%         timeStamp1 = [];
%         timeStamp2 = [];
%         timeStamp3 = [];
%         timeStamp4 = [];
%         timeStamp5 = [];
%         timeStamp6 = [];
%         timeStamp7 = [];
%         %timeStamp8 = [];
%         %timeStamp9 = [];
%         
%         h.figure1=figure('Name','Shimmer 1 signals');                      % Create a handle to figure for plotting data from shimmer
%         set(h.figure1, 'Position', [100, 500, 800, 400]);
%         
%         h.figure2=figure('Name','Shimmer 2 signals');                      % Create a handle to figure for plotting data from shimmer
%         set(h.figure2, 'Position', [100, 500, 800, 400]);
%         
%         elapsedTime = 0;                                                   % Reset to 0    
%         tic; % Start timer
        ctr = 0;
        while (true)            
            ctr = ctr +1;
            if ctr == 15
                disp('Lift Off!');                                                       
                sound(a2);
            end
            pause(DELAY_PERIOD);                                           % Pause for this period of time on each iteration to allow data to arrive in the buffer
            
            [newData1,signalNameArray,signalFormatArray,signalUnitArray] = shimmer1.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime1==true && isempty(newData1)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    commaNextSignalName = [char(44), char(signalNameArray(1,i))];                      % Add comma delimiter before signal name, number is ascii value of delimiter
                    signalNamesString = strcat(signalNamesString,commaNextSignalName);                  % Concatenate signal names delimited by a comma.
                 
                    firsttime1=false;
                end

                dlmwrite(fileName1, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end

            
            if ~isempty(newData1)   % TRUE if new data has arrived
                                
                dlmwrite(fileName1, newData1, '-append','precision',16); % Append the new data to the file in a comma delimited format,comma is default but others are supported as well
%Uncomment for plotting and add code for other shimmers                       
%                 plotData1 = [plotData1; newData1];                            % Update the plotDataBuffer with the new data
%                 numPlotSamples1 = size(plotData1,1);
%                 numSamples1 = numSamples1 + size(newData1,1);
%                 timeStampNew1 = newData1(:,1);                               % get timestamps
%                 timeStamp1 = [timeStamp1; timeStampNew1];
%                 
%                  if numSamples2 > NO_SAMPLES_IN_PLOT
%                         plotData1 = plotData1(numPlotSamples1-NO_SAMPLES_IN_PLOT+1:end,:);
%                  end
%                  sampleNumber1 = max(numSamples1-NO_SAMPLES_IN_PLOT+1,1):numSamples1;
%                  
               
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
%                  chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
%                  chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
%                  chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
%                               
                 
%                 set(0,'CurrentFigure',h.figure1);           
%                 subplot(2,2,1);                                            % Create subplot
%                 signalIndex = chIndex(1);
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
                    commaNextSignalName = [char(44), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,commaNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime2=false;
                end

                dlmwrite(fileName2, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end
            
            if ~isempty(newData2)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName2, newData2, '-append','precision',16); % Append the new data to the file in a tab delimited format
               
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
%                  chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
%                  chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
%                  chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
            end
            %shimmer3
            
            [newData3,signalNameArray,signalFormatArray,signalUnitArray] = shimmer3.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime3==true && isempty(newData3)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    commaNextSignalName = [char(44), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,commaNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime3=false;
                end

                dlmwrite(fileName3, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end
            
            if ~isempty(newData3)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName3, newData3, '-append','precision',16); % Append the new data to the file in a tab delimited format                
               
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
%                  chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
%                  chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
%                  chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
            end
            
            [newData4,signalNameArray,signalFormatArray,signalUnitArray] = shimmer4.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime4==true && isempty(newData4)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    commaNextSignalName = [char(44), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,commaNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime4=false;
                end

                dlmwrite(fileName4, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end

            
            if ~isempty(newData4)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName4, newData4, '-append','precision',16); % Append the new data to the file in a tab delimited format
 
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
%                  chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
%                  chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
%                  chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
%                               
            end
            
            %shimmer5
            
            [newData5,signalNameArray,signalFormatArray,signalUnitArray] = shimmer5.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime5==true && isempty(newData5)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    commaNextSignalName = [char(44), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,commaNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime5=false;
                end

                dlmwrite(fileName5, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end

            
            if ~isempty(newData5)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName5, newData5, '-append','precision',16); % Append the new data to the file in a tab delimited format
              
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
%                  chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
%                  chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
%                  chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
%                  
            end
            
            %shimmer6
            
            [newData6,signalNameArray,signalFormatArray,signalUnitArray] = shimmer6.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime6==true && isempty(newData6)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    commaNextSignalName = [char(44), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,commaNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime6=false;
                end

                dlmwrite(fileName6, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end

            
            if ~isempty(newData6)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName6, newData6, '-append','precision',16); % Append the new data to the file in a tab delimited format
                
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
%                  chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
%                  chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
%                  chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
            end
            
            %shimmer7
            
            [newData7,signalNameArray,signalFormatArray,signalUnitArray] = shimmer7.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
                        


            if (firsttime7==true && isempty(newData7)~=1) 
                signalNamesString = char(signalNameArray(1,1));                                           % Create a single string, signalNamesString         
                for i= 2:length(signalNameArray)                                                          % which lists the names of the enabled 
                    commaNextSignalName = [char(44), char(signalNameArray(1,i))];                         % Add tab delimiter before signal name
                    signalNamesString = strcat(signalNamesString,commaNextSignalName);                   % Concatenate signal names delimited by a tab.
                 
                    firsttime7=false;
                end

                dlmwrite(fileName7, signalNamesString, '%s');    % Write the signalNamesString as the first row of the file

            end

            
            if ~isempty(newData7)                                           % TRUE if new data has arrived
                                
                dlmwrite(fileName7, newData7, '-append','precision',16); % Append the new data to the file in a tab delimited format
                            
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
%                  chIndex(8) = find(ismember(signalNameArray, 'Magnetometer X'));
%                  chIndex(9) = find(ismember(signalNameArray, 'Magnetometer Y'));
%                  chIndex(10) = find(ismember(signalNameArray, 'Magnetometer Z'));
%                  
            end
        end
    end
end
end

