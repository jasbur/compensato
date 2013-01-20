//For this code to work you currently have to mount or link the host's local drive to
//"/media/customerdrive"

//Declaring variables from Node.js to manipulate the local file system and resources
var exec = require('child_process').exec;
var fs = require('fs');

//Main function for what will be the "Suspicious File Scan" feature of the program
//Currently this will search for all files of and "executable type" modified within
//a certain user-specific time frame. Later it should evolve into a full heuristic 
//scan looking for things like randomly generated file names, executables in
//unusual places, etc.
function fileScan(daysToScan){
	//An array of "executable" file extensions
	var extensions = [".dll", ".drv", ".exe", ".sys"];
	
	//findFiles will execute the built-in Linux "find" command and assign itself as 
	//a variable so we can keep an eye on it and access the "fullFileList" only 
	//when it's done with its search.
	var findFiles = exec("find /media/customerdrive/ -type f -mtime -" + daysToScan + " > fullFileList");
	
	//This will execute when the built-in "find" command is finished
	findFiles.on('exit', function(){
		//Open the locally stored full_file_list for processing
		var fullFileList = fs.readFileSync("fullFileList", 'utf8');
		//Split the file so each line is an element in the array
		var lines = fullFileList.split("\n");
		
		//Delete the fullFileList from the local file system
		fs.unlink("./fullFileList");
		
		//Assemble an array of only executable file types
		var executableFiles = checkForExtensions(lines, extensions);
		
		//Temporary code to make sure everything is working for now
		console.log(executableFiles.length + " executable files");
	});
}

//Checks to see which lines in the provided array match the given extension
//then returns an array of them
function checkForExtensions(lines, extensions){
	returnArray = new Array();
	
	for(l in lines){
		for (e in extensions){
			if(lines[l].indexOf(extensions[e]) > -1){
				returnArray.push(lines[l]);
			}
		}
	}
	
	return returnArray;
}

//Just manually triggering the "file_scan" function for testing purposes the variable is the amount of days 
//to scan back for suspicious files
fileScan(10);
