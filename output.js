var fs = require('fs');

module.exports = {
		
		clearScreen: function(){
			console.log("\u001B[2J\u001B[0;0f");
		},

		//Creates scan_log.txt from fullFileList
		createScanLog: function(lines, extensions){
			var linesToWrite = new Array();
			
			createScanLogHeader(lines, extensions, linesToWrite);
		}
		
};

//Creates the header for each extension in scan_log.txt
function createScanLogHeader(lines, extensions, linesToWrite, fn){
	for(e in extensions){
		linesToWrite.push("\n");
		linesToWrite.push("****************************************\n");
		linesToWrite.push("***** Recently modified " + extensions[e] + " files *****\n");
		linesToWrite.push("****************************************\n");
		linesToWrite.push("\n");
		checkForValidFiles(lines, extensions[e], linesToWrite);
	}
	writeLinesToFile(linesToWrite);
}

function checkForValidFiles(lines, extension, linesToWrite){
	//If the current line contains the current extension, write it to scan_log.txt
	for (l in lines){					
		if(lines[l].indexOf(extension) > -1){
			var fileStats = fs.statSync(lines[l]);
			linesToWrite.push(fileStats.mtime + " " + " " + fileStats.ctime + " " + lines[l] + "\n");
		}
	}
}

function writeLinesToFile(linesToWrite){
	fs.writeFileSync('./scan_log.txt', "");
	for(line in linesToWrite){
		fs.appendFileSync('./scan_log.txt', linesToWrite[line]);
	}
}