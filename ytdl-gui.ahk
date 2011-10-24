IniRead, DLfolder, ytdl.ini, Advanced, DownloadFolder, %A_MyDocuments%\Videos
IniRead, Template, ytdl.ini, Main, OutputTemplate, `%(upload_date)s_`%(stitle)s.`%(ext)s

Gui, Main:New
Gui, Add, Text, x12 y10 w450 h20 , Use this window to start a new Youtube download. Follow the steps provided then click Start.
Gui, Add, Text, x12 y60 w110 h20 , 1. Youtube URL
Gui, Add, Edit, x132 y60 w330 h20 vUrl, http://www.youtube.com/watch?v=
Gui, Add, Text, x12 y90 w450 h30 , Candidates for Youtube URLs are: One video URL`, playlist URLs`, videos from a user (ytuser)`, Youtube searches (ytsearch)
Gui, Add, Text, x12 y140 w110 h20 , 2. Filename
Gui, Add, Text, x12 y170 w450 h40 , The filename template uses special identifiers to give each file unique names. To use one`, type the variable in this way: `%(variable)s.`nAvailable variables are: id`, url`, uploader`, upload_date`, title`, stitle`, ext`, epoch`, autonumber.
Gui, Add, ComboBox, x132 y140 w330 h10 vTemplate, %Template%||`%(upload_date)s_`%(stitle)s.`%(ext)s|`%(epoch)s_`%(uploader)s_`%(stitle)s.`%(ext)s|`%(stitle).`%(ext)s
Gui, Add, Button, x182 y240 w110 h40 gDownload, Start Download
; Generate Menubar
Menu, Menubar, Add, Save Template, VarSave
Menu, Menubar, Add
Menu, Menubar, Add, Options, OptionsGUI
Gui, Menu, Menubar
; Display Window
Gui, Show, x414 y202 h300 w480, YouTubeDL GUI
Return

VarSave:
Gui, Submit, NoHide
Return

Download:
MsgBox, 8193, Youtube DL, A command window will now open.`nThe progress of your download will be shown here.,10
Gui, Submit, NoHide
RunWait, C:\Python27\python.exe C:\Users\neurario\Videos\youtube-dl.py -o "%Template%" %Url%, %DLfolder%
MsgBox, 8196, Youtube DL, Download complete! Open the output folder?
Return

OptionsGui:
Gui, Options:New
Gui, Options:Add, Text, x2 y9 w240 h30 , Output Directory: Change where the video(s) will be downloaded to. This folder must exist.
Gui, Options:Add, Edit, x2 y39 w190 h20 vDLfolder, %DLfolder%
Gui, Options:Add, Button, x192 y39 w50 h20 , Change
Gui, Options:Add, Button, x2 y69 w100 h30 gGuiSubmit, Submit Changes
Gui, Options:Add, Button, x142 y69 w100 h30 gGuiCancel, Cancel
; Generated using SmartGUI Creator 4.0
Gui, Options:Show, x127 y87 h112 w251, Options
Return

GuiSubmit:
Gui, Submit
Return

GuiCancel:
Gui, Cancel
Return

GuiClose:
IniWrite, %Template%, ytdl.ini, Main, OutputTemplate
IniWrite, %DLfolder%, ytdl.ini, Advanced, DownloadFolder
ExitApp