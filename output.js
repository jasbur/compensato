var fs = require('fs');

module.exports = {
		
		clearScreen: function(){
			console.log("\u001B[2J\u001B[0;0f");
		},

		createScanLog: function(lines, extensions){
			fs.writeFile('./scan_log.txt', "");
			
			for(l in lines){
				for (e in extensions){
					if(lines[l].indexOf(extensions[e]) > -1){
						fs.appendFile('./scan_log.txt', lines[l] + "\n");
					}
				}
			}
		}
		
};