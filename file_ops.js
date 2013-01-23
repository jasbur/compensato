var exec = require('child_process').exec;
var fs = require('fs');
var logic = require('./logic');

module.exports = {

	//Scans for executable type files modified within the given time frame
	fileScan: function(daysToScan){
		//An array of "executable" file extensions
		var extensions = [".dll", ".drv", ".exe", ".sys"];
		
		//Use OS "find" command to do the searching and dump the output to fullFileList
		var findFiles = exec("find /media/customerdrive/ -type f -mtime -" + daysToScan + " > fullFileList");
		
		findFiles.on('exit', function(){
			//Open the locally stored fullFileList for processing
			var fullFileList = fs.readFileSync("fullFileList", 'utf8');
			var lines = fullFileList.split("\n");
			//Delete the temporary file
			fs.unlink("./fullFileList");
			
			//Assemble an array of only executable file types
			var executableFiles = logic.checkForExtensions(lines, extensions);
			
			//Temporary code to make sure everything is working for now
			console.log(executableFiles.length + " executable files");
		});
	}
	
};