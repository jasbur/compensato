var exec = require('child_process').exec;
var fs = require('fs');

function file_scan(){
	var findFiles = exec("find /media/customerdrive/ -type f > full_file_list");
	
	findFiles.on('exit', function(){
		var fullFileList = fs.readFileSync("full_file_list", 'utf8');
		var lines = fullFileList.split("\n");
		
		var numFiles = 0;
		for(l in lines){
			if(lines[l].indexOf("exe") > -1){
				numFiles++;
			}
		}
		
		console.log(numFiles + " .exe files");
	});
}

file_scan();
