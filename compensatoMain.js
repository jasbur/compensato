//For this code to work you currently have to mount or link the host's local drive to
//"/media/customerdrive"
var fileOps = require('./file_ops');
var output = require('./output');

output.clearScreen();

console.log("Welcome to Compensato!");
console.log();
console.log("Now, let's fix this computer. Choose one of the options below:");
console.log();
console.log("[1] Scan for suspicious files");
console.log("[Q] Quit");

process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function (text) {
    switch (text){
    case "1\n":
    	output.clearScreen();
    	console.log("Scanning back 30 days for suspicious files...");
    	fileOps.fileScan(30);
    	break;
    case "q\n":
    	output.clearScreen();
    	process.exit();
    	break;
    case "Q\n":
    	output.clearScreen();
    	process.exit();
    	break;
    }
});