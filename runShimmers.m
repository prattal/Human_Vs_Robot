close all
clear all
% t=datetime('now');
% t.Format = 'yyyyMMddhhmm';
filename1 = 'C:\Users\Administrator\Desktop\temp_dir\E91B.csv';             %File Paths to where data will be saved temporarily
filename2 = 'C:\Users\Administrator\Desktop\temp_dir\E912.csv';
filename3 = 'C:\Users\Administrator\Desktop\temp_dir\E84F.csv';
filename4 = 'C:\Users\Administrator\Desktop\temp_dir\E887.csv';
filename5 = 'C:\Users\Administrator\Desktop\temp_dir\E863.csv';
filename6 = 'C:\Users\Administrator\Desktop\temp_dir\E906.csv';
filename7 = 'C:\Users\Administrator\Desktop\temp_dir\E8D2.csv';
plotandwriteexample_sevenshimmer('4','7','9','10','12','14','16',filename1... %Command that runs the function with the given arguments 
    ,filename2,filename3,filename4,filename5,filename6,filename7)