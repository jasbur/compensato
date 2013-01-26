var fs = require('fs');

module.exports = {
		
		clearScreen: function(){
			console.log("\u001B[2J\u001B[0;0f");
		},

		//Creates scan_log.txt from fullFileList
		createScanLog: function(lines, extensions){
			fs.writeFileSync('./scan_log.txt', "");
			
			for(e in extensions){
				createScanLogHeader(extensions[e]);
				
				//If the current line contains the current extension, write it to scan_log.txt
				for (l in lines){					
					if(lines[l].indexOf(extensions[e]) > -1){
						fs.appendFileSync('./scan_log.txt', lines[l] + "\n");
					}
				}
			}
		}
		
};

//Creates the header for each extension in scan_log.txt
function createScanLogHeader(extension){
	fs.appendFileSync('./scan_log.txt', "\n");
	fs.appendFileSync('./scan_log.txt', "****************************************\n");
	fs.appendFileSync('./scan_log.txt', "***** Recently modified " + extension + " files *****\n");
	fs.appendFileSync('./scan_log.txt', "****************************************\n");
	fs.appendFileSync('./scan_log.txt', "\n");
}