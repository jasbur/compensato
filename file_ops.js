var exec = require('child_process').exec;
var fs = require('fs');
var output = require('./output');

module.exports = {

	//Scans for executable type files modified within the given time frame
	fileScan: function(daysToScan){
		//An array of "executable" file extensions
		var extensions = [".bat", ".cmd", ".drv", ".exe", ".sys"];
		
		//Use OS "find" command to do the searching and dump the output to fullFileList
		console.log();
		console.log("Building a list of all files modified within " + daysToScan + " days...");
		var findFiles = exec("find /media/customerdrive/ -type f -mtime -" + daysToScan + " > fullFileList");
		
		findFiles.on('exit', function(){
			//Open the locally stored fullFileList for processing
			var fullFileList = fs.readFileSync("fullFileList", 'utf8');
			var lines = fullFileList.split("\n");
			//Delete the temporary file
			fs.unlink("./fullFileList");
			
			console.log();
			console.log("Creating sca_log.txt...");
			output.creatScanLog(lines, extensions);
			
//			//Assemble an array of only executable file types
//			var executableFiles = logic.checkForExtensions(lines, extensions);
//			
//			//Temporary code to make sure everything is working for now
//			console.log(executableFiles.length + " executable files");
		});
	}
	
};