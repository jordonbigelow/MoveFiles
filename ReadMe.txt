This is a script that was designed to move files in a directory into a new folder to prepare for deletion or just movement into a new location. It takes user input to decide where to move all of the files to. The details of the program are below in the order the program executes them. If you have any questions, please reach out to Jordon Bigelow.

---If you would like to use this remotely, you will need to compile it into an exe. Simply download the code and use the AutoIT editor to "build" an exe for you. This program requires admin privledges---

1. The program grabs user input for the location of the files you are trying to move. This is stored as a variable called $userDirectory.
	-If the filepath is left blank, an error will display telling the user that the path cannot be blank.
	-This will keep on looping until an input is typed in.
	-The program is not designed to check if the path is valid, so please just copy paste the location you are working with.
	-If at any moment the cancel button is pushed, the script will end.

2. The program then grabs user input for the name of the folder to be created where the files will be moved into. This is stored as a variable called $userFolderName.
	-If the file name is left blank, an error will display telling the user that the path cannot be blank.
	-This will keep on looping until an input is typed in.
	-The program is not designed to check if the path is valid, so please just copy paste the location you are working with.
	-If at any moment the cancel button is pushed, the script will end.
	
3. The program will now call cmd.exe to open
	-The program navigates to the path that was input in step 1.
	-The program then navigates into the folder that was named in step 2.
	-The program creates a directory called "Log".
	-The program navigates to that directory and creates a file called "log.txt" for logging purposes.
	-It then closes the open cmd.exe window
	
4. The program grabs user input for the location of the CSV file you will be using
	-If the filepath is left blank, an error will display telling the user that the path cannot be blank.
	-This will keep on looping until an input is typed in.
	-The program is not designed to check if the path is valid, so please just copy paste the location you are working with.
	-If at any moment the cancel button is pushed, the script will end.
	
5. The program grabs user input for the name of the CSV file you will be using
	-If the file name is left blank, an error will display telling the user that the path cannot be blank.
	-This will keep on looping until an input is typed in.
	-The program is not designed to check if the path is valid, so please just copy paste the location you are working with.
	-If at any moment the cancel button is pushed, the script will end.
	
6. The program then opens the CSV file
	-If it cannot open the file an error is displayed, "Unable to open the file."
	-A file may fail to open due to access rights or attributes.
	-If this happens, make sure the file path and the file name for the CSV are both typed correctly. Copy Paste works best here.
	
7. The program then writes the file's contents into a 2 dimentional array aka rows and columns
	-When it is reading the CSV file, it is seperating the cells based on a ',' comma character.
	-Once it hits a comma, it knows that is the end of a cell.
	
8. The program then displays a Message to the user giving the path the files will be moved to
	-If the user clicks cancel, the whole script stops and it's as if nothing ever happened
	-If the user clicks OK, the script moves on.
	
9. The program then loops through the entire array one element at a time
	-If the file exists, the file is moved and a message is logged to "log.txt" saying that it has been moved successfully.
	-If the file doesn't exist, an error message is displayed to the user and a message is logged to "log.txt"
	-There is no progress bar while files are being moved.
	-I find it best to have the location where the files are being moved open so I can see the files being moved.

10. The CSV file is then closed by the program

11. A message is displayed to the user saying that the files have been moved and a log file has been created.