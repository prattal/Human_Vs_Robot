clear all                                                                   %Clear the workspace variables
close all                                                                   %Close all open figures
clc                                                                         %Clear the Command Window

filename1 = 'C:\Users\Administrator\Desktop\temp_dir\E91B.csv ';            %File path to where the data is saved
filename2 = 'C:\Users\Administrator\Desktop\temp_dir\E912.csv ';            %Make sure there is a space after the v but before the comma
filename3 = 'C:\Users\Administrator\Desktop\temp_dir\E84F.csv ';
filename4 = 'C:\Users\Administrator\Desktop\temp_dir\E887.csv ';
filename5 = 'C:\Users\Administrator\Desktop\temp_dir\E863.csv ';
filename6 = 'C:\Users\Administrator\Desktop\temp_dir\E906.csv ';
filename7 = 'C:\Users\Administrator\Desktop\temp_dir\E8D2.csv';
fileList = [filename1, filename2,filename3,filename4,filename5,filename6,filename7]; %Put the files in an array
files = strsplit(fileList);                                                 %Split them in to distinct cells
shimmerNames = ['E91B-Green3 ','E912-Blue4 ','E84F-Blue5 ','E887-Blue6 '...
    ,'E863-Red7 ','E906-Red8 ','E8D2-Red9'];    %Define names and put them in an array
shimmers = strsplit(shimmerNames);                                          %Split them into distinct cells
blockOperations = zeros(1,7);                                               %Initialize array            
blockNames = 'Green3,Blue4,Blue5,Blue6,Red7,Red8,Red9';
locFileName = 'C:\Users\Administrator\Desktop\temp_dir\locations.csv';
dlmwrite(locFileName,blockNames, '%s');
for i = 1:7                                                                 %Do the following code for both files
    T = readtable(char(files(i)),'ReadVariableNames',1);                    %Read in the file
    Time_Stamp = T.Time_Stamp;                                               %Set File Time Stamp data to variable
    Time_Stamp_Scaled = Time_Stamp-Time_Stamp(1);                           %Scale Time Stamp to start at zero
    Time_Stamp_Scaled = Time_Stamp_Scaled./1000;                            %Convert to Seconds
    time = Time_Stamp_Scaled;
 
    accx = T.Low_Noise_Accelerometer_X;                                        %Save Each data column to a variable
    accy = T.Low_Noise_Accelerometer_Y;
    accz = T.Low_Noise_Accelerometer_Z;
    
    accy = accy -9.8;                                                       %Subtract 9.8 from all Y values so that it is centered at zero      
    
    accx = medfilt1(accx,5);                                                %Run each column through a median filter
    accy = medfilt1(accy,5);
    accz = medfilt1(accz,5);
                                            
    figure 

    plot(time,accx)                                                         %Plot X, Y, and Z Data on the same plot
    xlabel('Time (sec)')
    ylabel('Acceleration X(m/sec^2)')
    title(char(shimmers(i)));
    
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
    title(char(shimmers(i)));
    hold on 
    plot(time,diff);
    legend('total','upper','lower','diff');
    
    [pks,locs] = findpeaks(diff,time,'MinPeakDistance', 2.5, 'MinPeakHeight',3); %Find the peaks of the diff data set and restrict what it counts as a peak to the given parameters
    locations = (locs*1000)+T.Time_Stamp_Unix(1);
    dlmwrite(locFileName,locations, '-append','precision',16, 'delimiter',',','coffset',i-1);
    fprintf('The number of block operations is %d\n', length(pks));         %Print the number of peaks for each block
    blockOperations(i) = length(pks);
end
Green3=blockOperations(1);Blue4=blockOperations(2);Blue5=blockOperations(3);    %Set the number of block operations for each block to their corresponding shimmer names
Blue6=blockOperations(4);Red7=blockOperations(5);Red8=blockOperations(6);
Red9=blockOperations(7);
t = table(Green3,Blue4,Blue5,Blue6,Red7,Red8,Red9);                              %Make a formatted table with the name and number of operations
writetable(t,'C:\Users\Administrator\Desktop\temp_dir\blockOperations2.csv');%Save table to a file
