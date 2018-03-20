clear all                                                                   %Clear all Workspace Variables

close all                                                                   %Close all open figure windows

clc;                                                                        %Clear the Command Window
filename1 = 'C:\Users\Administrator\Desktop\temp_dir\E8E3.csv ';            %File path to where the data is saved
filename2 = 'C:\Users\Administrator\Desktop\temp_dir\E913.csv ';            %Make sure there is a space after the v before the comma
fileList = [filename1, filename2];                                          %Put the files in an array
files = strsplit(fileList);                                                 %Split them in to distinct cells
shimmerNames = ['E8E3-Green1 ', 'E913-Green2'];                                           %Define names and put them in an array
shimmers = strsplit(shimmerNames);                                          %Split them into distinct cells
blockOperations = zeros(1,2);                                               %Initialize array            
for f = 1:2                                                                 %Do the following code for both files
    T = readtable(char(files(f)),'ReadVariableNames',1);                    %Read in the file
    Time_Stamp = T.TimeStamp;                                               %Set File Time Stamp data to variable
    Time_Stamp_Scaled = Time_Stamp-Time_Stamp(1);                           %Scale Time Stamp to start at zero
    Time_Stamp_Scaled = Time_Stamp_Scaled./1000;                            %Convert to Seconds
    time = Time_Stamp_Scaled;
 
    accx = T.LowNoiseAccelerometerX;                                        %Save Each data column to a variable
    accy = T.LowNoiseAccelerometerY;
    accz = T.LowNoiseAccelerometerZ;
    
    accy = accy -9.8;                                                       %Subtract 9.8 from all Y values so that it is centered at zero      
    
    accx = medfilt1(accx,3);                                                %Run each column through a median filter
    accy = medfilt1(accy,3);
    accz = medfilt1(accz,3);
                                            
    figure 

    plot(time,accx)                                                         %Plot X, Y, and Z Data on the same plot
    xlabel('Time (sec)')
    ylabel('Acceleration X(m/sec^2)')
    title(char(shimmers(f)));
    
    hold on
    plot(time,accy)
    xlabel('Time (sec)')
    ylabel('Acceleration Y(m/sec^2)')
    
    hold on
    plot(time,accz)
    xlabel('Time (sec)')
    ylabel('Acceleration Z(m/sec^2)')
    legend('X','Y','Z')
    
    total = accx+accy+accz;                                                 %Add the data arrays together
    np = 45;                                                                %Number that correlates to how tightly or loosely you want the envelope to fit around the data, tighter go down, looser go up
    [upper,lower] = envelope(total, np, 'peak');                            %envelope the data and save two data sets for the top of positive peaks and the negative peaks
    diff = upper-lower;                                                     %subtract the two new data sets to get a difference of the two
    
    figure                                                                  %Plot the total, upper, lower, and diff data sets on the same plot
    plot(time,total);
    hold on
    plot(time, upper);
    hold on
    plot(time,lower);
    xlabel('Time (sec)');
    ylabel('Acceleration Sum(m/sec^2)');
    title(char(shimmers(f)));
    hold on 
    plot(time,diff);
    legend('total','upper','lower','diff');
    
    [pks,locs] = findpeaks(diff,time,'MinPeakDistance', 2, 'MinPeakHeight',6); %Find the peaks of the diff data set and restrict what it counts as a peak to the given parameters
    fprintf('The number of block operations is %d\n', length(pks));         %Print the number of peaks for each block
    blockOperations(f) = length(pks);
end
Green1=blockOperations(1);Green2=blockOperations(2);                            %Set the number of block operations for each block to their corresponding shimmer names
t = table(Green1,Green2);                                                       %Make a formatted table with the name and number of operations
writetable(t,'C:\Users\Administrator\Desktop\temp_dir\blockOperations1.csv');%Save table to a file
