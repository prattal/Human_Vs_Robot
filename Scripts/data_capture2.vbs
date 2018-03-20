'data_capture.vbs
'authored by Shay Merley merleyst@rose-hulman.edu

Dim FSO
Dim WshShell
Dim temp_dir
Dim new_dir

'pad zeros onto dat-time string
Function LPad (str, pad, length)
    LPad = String(length - Len(str), pad) & str
End Function

'directory name based on current date and time
new_dir = CStr(DatePart("yyyy",Date)) & LPad(Month(Date), "0", 2) & LPad(Day(Date), "0", 2) & LPad(Hour(Time), "0", 2) & LPad(Minute(Time), "0", 2)

'file and script object
Set FSO = CreateObject("Scripting.FileSystemObject")
Set WshShell = WScript.CreateObject("WScript.Shell")

'create temporary directory to store data until end of script
temp_dir = "C:\Users\Administrator\Desktop\temp_dir"
FSO.CreateFolder(temp_dir)

'run matlab shimmer tracking
WshShell.Run """C:\Users\Administrator\Documents\MATLAB\Add-Ons\Toolboxes\Shimmer MATLAB Instrument Driver\code\runShimmers.m"""
WScript.Sleep 20000
WshShell.Sendkeys "{F5}"
WScript.Sleep 1000

'matlab shimmer tracking takes a long time to initialize so we wait
WScript.Sleep 60000

'open and start camera
WshShell.Run """C:\Users\Administrator\Desktop\OBS Studio (64bit)"""
WScript.Sleep 23000
WshShell.Sendkeys "{F7}" 'F7 starts recording
WScript.Sleep 500

WshShell.AppActivate "MATLAB R2017a - academic use"
WScript.Sleep 1000

WshShell.AppActivate "c:\windows\system32\cscript.exe"

'wait for user to press enter
strMessage = "Press the ENTER key to quit. "
WScript.StdOut.Write strMessage
Do While Not WScript.StdIn.AtEndOfLine
   Input = WScript.StdIn.Read(1)
Loop

'close camera
WScript.Sleep 500
WshShell.AppActivate "OBS 19.0.3 (64bit, windows) - Profile: Untitled - Scenes: Untitled"
WshShell.Sendkeys "{F7}"
WScript.Sleep 1000
WshShell.Sendkeys "%{F4}"

'stop matlab shimmer tracking
WScript.Sleep 2000
WshShell.AppActivate "MATLAB R2017a - academic use"
WScript.Sleep 2000
WshShell.Sendkeys "^0"  'navigate to command line
WScript.Sleep 1000
WshShell.Sendkeys "^c"  'kill process
Wscript.Sleep 1000

'run another matlab script that processes shimmer data into block operations
WshShell.Run """C:\Users\Administrator\Documents\MATLAB\operation_counter_multi.m"""
WScript.Sleep 1000
WshShell.Sendkeys "{F5}"
Wscript.Sleep 10000
WshShell.SendKeys "^0"
WScript.Sleep 1000
WshShell.SendKeys "^c"
WScript.Sleep 1000

'close matlab and 7 error windows that come up from the shimmer code
WshShell.Sendkeys "%{F4}"
WScript.Sleep 3000
for i = 0 To 6
WshShell.AppActivate "Application Error"
WScript.Sleep 500
WshShell.Sendkeys "%{F4}"
WScript.Sleep 500
Next

'rename directory based on date and time
FSO.GetFolder(temp_dir).Name = new_dir

WScript.Echo "Finished."