// Declaring variables from Node.js to manipulate the local file system and resources
var exec = require('child_process').exec;
var fs = require('fs');

/*
 * Main function for what will be the "Suspicious File Scan" feature of the program
 * Currently this will search for all files of and "executable type" modified within
 * a certain user-specific time frame. Later it should evolve into a full heuristic 
 * scan looking for things like randomly generated file names, executables in
 * unusual places, etc.
*/
function file_scan(){
	/*
	 * findFiles will execute the built-in Linux "find" command and assign itself as 
	 * a variable so we can keep an eye on it and access the "full_file_list" only 
	 * when it's done with its search.
	*/
	var findFiles = exec("find /media/customerdrive/ -type f > full_file_list");
	// Declaring Arrays to hold the strings referencing the executable files for later examination
	var exeFiles = new Array();
	var dllFiles = new Array();
	var sysFiles = new Array();
	var drvFiles = new Array();
	
	// This will execute when the built-in "find" command is finished
	findFiles.on('exit', function(){
		// Open the locally stored full_file_list for processing
		var fullFileList = fs.readFileSync("full_file_list", 'utf8');
		// Split the file so each line is an element in the array
		var lines = fullFileList.split("\n");
		
		// Check each line for one of the executable types and push it into its appropriate array if found
		for(l in lines){
			if(lines[l].indexOf(".exe") > -1){
				exeFiles.push(lines[l]);
			}else if(lines[l].indexOf(".dll") > -1){
				dllFiles.push(lines[l]);
			}else if(lines[l].indexOf(".sys") > -1){
				sysFiles.push(lines[l]);
			}else if(lines[l].indexOf(".drv") > -1){
				drvFiles.push(lines[l]);
			}
		}
		
		// Temporary code to make sure everything is working for now
		console.log(exeFiles.length + " .exe files");
		console.log(dllFiles.length + " .dll files");
		console.log(sysFiles.length + " .sys files");
		console.log(drvFiles.length + " .drv files");
	});
}

file_scan();
