//For this code to work you currently have to mount or link the host's local drive to
//"/media/customerdrive"
var fileOps = require('./file_ops');

//Just manually triggering the "file_scan" function for testing purposes the variable is the amount of days 
//to scan back for suspicious files
fileOps.fileScan(10);