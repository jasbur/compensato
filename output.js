var fs = require('fs');

module.exports = {
		
		clearScreen: function(){
			console.log("\u001B[2J\u001B[0;0f");
		},

		createScanLog: function(lines, extensions){
			fs.writeFileSync('./scan_log.txt', "");
			
			for(e in extensions){
				createScanLogHeader(extensions[e]);
				
				for (l in lines){					
					if(lines[l].indexOf(extensions[e]) > -1){
						fs.appendFileSync('./scan_log.txt', lines[l] + "\n");
					}
				}
			}
		}
		
};

function createScanLogHeader(extension){
	fs.appendFileSync('./scan_log.txt', "\n");
	fs.appendFileSync('./scan_log.txt', "****************************************\n");
	fs.appendFileSync('./scan_log.txt', "***** Recently modified " + extension + " files *****\n");
	fs.appendFileSync('./scan_log.txt', "****************************************\n");
	fs.appendFileSync('./scan_log.txt', "\n");
}