var exec = require('child_process').exec;
var fs = require('fs');

function file_scan(){
	var findFiles = exec("find /media/customerdrive/ -type f > full_file_list");
	var exeFiles = new Array();
	var dllFiles = new Array();
	var sysFiles = new Array();
	var drvFiles = new Array();
	
	findFiles.on('exit', function(){
		var fullFileList = fs.readFileSync("full_file_list", 'utf8');
		var lines = fullFileList.split("\n");
		
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
		
		console.log(exeFiles.length + " .exe files");
		console.log(dllFiles.length + " .dll files");
		console.log(sysFiles.length + " .sys files");
		console.log(drvFiles.length + " .drv files");
	});
}

file_scan();
