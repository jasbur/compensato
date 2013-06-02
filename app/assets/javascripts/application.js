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

//Calls the file_copy_progress action in the file_ops controller avery 30 seconds
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

//Closes the current tab or window after the amount of milliseconds provided have elapsed
function close_this_window_in(milliseconds){
	setTimeout (function (){
		window.close();
	}, milliseconds)
}

//Updates the given form field with the given text
function update_form_text_field(field_id, field_value){
	var form_field = document.getElementById(field_id);
	form_field.value = field_value;
}
