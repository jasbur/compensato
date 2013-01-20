module.exports = {
		
	//Checks to see which lines in the provided array match the given extension
	//then returns an array of them
	checkForExtensions: function(lines, extensions){
		returnArray = new Array();
		
		for(l in lines){
			for (e in extensions){
				if(lines[l].indexOf(extensions[e]) > -1){
					returnArray.push(lines[l]);
				}
			}
		}
		
		return returnArray;
	}

};