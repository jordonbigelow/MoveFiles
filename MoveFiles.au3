#RequireAdmin
#include <Array.au3>
#include <File.au3>

;This program is designed to move files that contain a 'y' in the second column of a .csv file

Do ;Get the path where the new folder will be created
   Const $userDirectory = InputBox("Folder Location", "Please enter in the path you want to create your folder in. Spaces aren't allowed. Then press OK.")
   If @error = 1 Then
		 Exit
   EndIf
   If $userDirectory = "" Then
	  MsgBox(0, "Error", "The path cannot be blank.")
   EndIf
Until $userDirectory <> ""

Do ;Get the folder name where the files will be moved
   Const $userFolderName = InputBox("Folder Name", "Please enter in the name of your new folder. Spaces aren't allowed. Then press OK.")
   If @error = 1 Then
	  Exit
   EndIf
   If $userFolderName = "" Then
	  MsgBox(0, "Error", "The folder name cannot be blank.")
   EndIf
Until $userFolderName <> ""

#Region ;Navigate to the directory and create the new folder
Sleep(500)
Run("cmd.exe")
WinWaitActive("Administrator: C:\WINDOWS\SYSTEM32\cmd.exe")
Send("pushd " & $userDirectory)
Send("{ENTER}")
Send("mkdir " & $userFolderName)
Send("{ENTER}")
Send("pushd " & $userFolderName)
Send("{ENTER}")
Send("mkdir Log")
Send("{ENTER}")
Send("pushd Log")
Send("{ENTER}")
Send("type nul > log.txt")
Send("{ENTER}")
Sleep(1000)
WinClose("Administrator: C:\WINDOWS\SYSTEM32\cmd.exe")
#EndRegion

Do ;Get the CSV file location
   Const $csvPath = InputBox("CSV Location", "Please enter in the location of your csv file. Then press OK.")
   If @error = 1 Then
		 Exit
   EndIf
   If $csvPath = "" Then
	  MsgBox(0, "Error", "The path cannot be blank.")
   EndIf
Until $csvPath <> ""

Do ;Get the CSV file name
   Const $csvFile = InputBox("CSV File", "Please enter the CSV file name. Then press OK.")
   If @error = 1 Then
		 Exit
   EndIf
   If $csvFile = "" Then
	  MsgBox(0, "Error", "The file name cannot be blank.")
   EndIf
Until $csvFile <> ""

#Region ;Open the CSV file
Const $fileContents = FileOpen($csvPath & "\" & $csvFile & ".csv")
If $fileContents = -1 Then
   MsgBox(0, "Error", "Unable to open the file.")
   Exit
EndIf
#EndRegion

#Region ;Put the csv file contents into a 2D array. Delimiter is a ",".
Local $csvFileArray[0][0]
_FileReadToArray($csvPath & "\" & $csvFile & ".csv", $csvFileArray, 1, ",")
If @error = 1 Then
   MsgBox(0, "Error", "Array is not an array.")
   Exit
EndIf
FileClose($fileContents)
#EndRegion

MsgBox(0, "Confirmation", "Your files will be moved to " & $userDirectory & "\" & $userFolderName & "\ | Please confirm by pressing OK. There will be no progress indicator.")

#Region ;Loop through the array and analyze it's second column content then move the content to the new folder
Local $index

For $index = 1 To UBound($csvFileArray) - 1
   If StringCompare($csvFileArray[$index][1], "y") = 0 Then
	  Local $fileFound = FileMove($userDirectory & "\" & StringStripWS($csvFileArray[$index][0], 1), $userDirectory & "\" & $userFolderName & "\" & StringStripWS($csvFileArray[$index][0], 1))
	  Local $logFile = FileOpen($userDirectory & "\" & $userFolderName & "\Log\Log.txt")

	  If $fileFound = 0 Then
		 MsgBox(0, "Error", StringStripWS($csvFileArray[$index][0], 1) & " could not be found. It will be skipped.")
		 _FileWriteLog($userDirectory & "\" & $userFolderName & "\Log\Log.txt", "!!!--- " & StringStripWS($csvFileArray[$index][0], 1) & " doesn't exist ---!!!")
		 FileClose($logFile)
	  EndIf

	  If $fileFound = 1 Then
		 _FileWriteLog($userDirectory & "\" & $userFolderName & "\Log\Log.txt", StringStripWS($csvFileArray[$index][0], 1) & " moved succesfully.")
		 FileClose($logFile)
	  EndIf
   EndIf
Next
#EndRegion

MsgBox(0, "Finished", "Files Moved! Log file created of files successfully moved.")