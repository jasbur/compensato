// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

//Calls the file_copy_progress action in the file_ops controller every 30 seconds
function file_copy_progress(directory, source_directory_files){
	setInterval(function(){
		$('#file_copy_progress').load('/file_ops/file_copy_progress?destination_directory=' + directory + '&source_directory_files=' + source_directory_files);
	}, 30000);
}

//Calls the check_system_temps action in the diagnostics controller every 1 second
function check_system_temps(){
	setInterval(function(){
		$('#systemTemps').load('/diagnostics/check_system_temps');
	}, 1000);
}

//Updates the given form field with the given text
function update_form_text_field(field_id, field_value){
	var form_field = document.getElementById(field_id);
	form_field.value = field_value;
}

//Replaces the contents of the "folderCopyBrowser" div in /file_ops/new?file_op_type=complete_folder_copy 
//with the output of the /file_ops/folder_browser action
function folder_browser_refresh(user_selected_directory){
	$('#folderCopyBrowser').load('/file_ops/folder_browser?user_selected_directory=' + user_selected_directory);
}

//Loads the provided html file into the provided div when the specified link is clicked. The "visible" 
//variable is boolean and determines whether or not to trigger the jquery .show() is run on 
//the the div_to_load_into
function load_action_in_hidden_div(clicked_link_id, url_to_load, div_to_load_into, visible){
	$("#" + clicked_link_id).click(function(){
		if (visible == true){
			$("#" + div_to_load_into).show();
		};
		
		$("#" + div_to_load_into).load(url_to_load);
	})
}
