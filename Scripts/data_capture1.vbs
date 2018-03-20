'data_capture.vbs
'authored by Shay Merley merleyst@rose-hulman.edu
'This script uses keyboard and window selection controls to run several data_collection programs,
'waits for user input, then closes them all and saves the data to a single directory

'declare variables
Dim FSO
Dim WshShell
Dim temp_dir
Dim new_dir
Dim audio_timestamp

'adds padding zeroes to date-time string
Function LPad (str, pad, length)
    LPad = String(length - Len(str), pad) & str
End Function

'changes current date to unix time
function date2epoch(myDate)
date2epoch = DateDiff("s", "01/01/1970 00:00:00", myDate)
end function

'final name of directory--example: 201707241301 is July 24, 2017 at 1:01 p.m.
new_dir = CStr(DatePart("yyyy",Date)) & LPad(Month(Date), "0", 2) & LPad(Day(Date), "0", 2) & LPad(Hour(Time), "0", 2) & LPad(Minute(Time), "0", 2)

'file object and script object
Set FSO = CreateObject("Scripting.FileSystemObject")
Set WshShell = WScript.CreateObject("WScript.Shell")

'creates temporary directory for all the data to be stored until the end of the script
temp_dir = "C:\Users\Administrator\Desktop\temp_dir"
FSO.CreateFolder(temp_dir)

'run arduino for glove
WshShell.Run "C:\Users\Administrator\Desktop\the-final-flex\the-final-flex.ino" 
WScript.Sleep 6000 
WshShell.SendKeys "^u" 'Ctrl+U uploads arduino code

'run matlab shimmer tracking
WshShell.Run """C:\Users\Administrator\Documents\MATLAB\Add-Ons\Toolboxes\Shimmer MATLAB Instrument Driver\code\two_shimmer_shortcut.m"""
WScript.Sleep 16000
WshShell.Sendkeys "{F5}"

'close arduino
WShShell.AppActivate "the-final-flex | Arduino 1.8.3" 'AppActivate brings forward the window with the given title
WScript.Sleep 750
WshShell.Sendkeys "%{F4}" 'Alt+F4 closes window


'run processing code for glove
WshShell.Run """C:\Users\Administrator\Desktop\processing data\glove_capture\glove_capture.pde""" 'triple quotes allow for spaces
WScript.Sleep 9000
WshShell.Sendkeys "^r"
WScript.Sleep 750

'run kinect skeleton tracking
WshShell.Run "C:\Users\Administrator\Desktop\skeleton_capture_dir\skeleton_capture.py"
WScript.Sleep 750

'run image capturing
'WshShell.Run "C:\Users\Administrator\Desktop\img_capture_dir\img_capture.py"
'WScript.Sleep 1000
WshShell.Run """C:\Users\Administrator\Desktop\OBS Studio (64bit)"""
WScript.Sleep 5000
WshShell.Sendkeys "{F7}" 'F7 starts recording
Wscript.Sleep 500

'run audio capture
WshShell.Run "C:\Users\Administrator\Desktop\Audacity"
WScript.Sleep 57000
audio_timestamp = date2epoch(Now())+14400 'seconds since epoch plus 14400 for time-zone difference (from UTC)
WshShell.Sendkeys "+r"
WScript.Sleep 1000

WshShell.AppActivate "c:\windows\system32\cscript.exe"

'waits for user to press enter
strMessage = "Press the ENTER key to quit. "
WScript.StdOut.Write strMessage
Do While Not WScript.StdIn.AtEndOfLine
   Input = WScript.StdIn.Read(1)
Loop

'close audacity
WshShell.AppActivate "Audacity"
WScript.sleep 2500
WshShell.Sendkeys " "  'spacebar stops recording
WScript.sleep 2500 
WshShell.Sendkeys "^+e"  'export recording
WScript.sleep 2500
WshShell.Sendkeys "C:\Users\Administrator\Desktop\temp_dir\"
WshShell.Sendkeys audio_timestamp          
WshShell.Sendkeys "{Enter}"                                   'saves audio file and names it after the time it started
WScript.sleep 500
WshShell.Sendkeys "{Enter}"
WScript.sleep 1500
WshShell.Sendkeys "%{F4}"
WScript.sleep 500
WshShell.Sendkeys "{RIGHT}"
WScript.sleep 500
WshShell.Sendkeys "{Enter}"   'do not save project upon close

'close kinect capture
WshShell.AppActivate "C:\Python27\python.exe"
WScript.Sleep 750
WshShell.Sendkeys "^c"  'ctrl+c to stop python script
WScript.Sleep 1000

'close camera
WshShell.AppActivate "OBS 19.0.3 (64bit, windows) - Profile: Untitled - Scenes: Untitled"
WshShell.Sendkeys "{F7}"
WScript.Sleep 1000
WshShell.Sendkeys "%{F4}"

'stop matlab recording
WScript.Sleep 2000
WshShell.AppActivate "MATLAB R2016a - academic use"
WshShell.Sendkeys "^0"     'navigate to command line
WScript.Sleep 1000
WshShell.Sendkeys "^c"
Wscript.Sleep 2000

'run additional matlab script that processes shimmer data into block operations
WshShell.Run """C:\Users\Administrator\Documents\MATLAB\operation_counter_multi.m"""
Wscript.Sleep 3000
WshShell.Sendkeys "{F5}"
WScript.Sleep 15000
WshShell.Sendkeys "^0"
WScript.Sleep 1000
WshShell.Sendkeys "^c"
WScript.Sleep 1000

'using the shimmers throws error windows upon closing--these lines close the error windows
WshShell.Sendkeys "%{F4}"
WScript.Sleep 3000
WshShell.AppActivate "Application Error"
WScript.Sleep 500
WshShell.Sendkeys "%{F4}"
WScript.Sleep 500
WshShell.AppActivate "Application Error"
WScript.Sleep 500
WshShell.Sendkeys "%{F4}"

'close processing
WScript.Sleep 750
WshShell.AppActivate "glove_capture | Processing 3.3.5"
WScript.Sleep 750
WshShell.Sendkeys "%{F4}"
WScript.sleep 1000

FSO.GetFolder(temp_dir).Name = new_dir     'rename directory as timestamp

WScript.Echo "Finished."


