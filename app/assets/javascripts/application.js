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

function file_copy_progress(directory, source_directory_files){
	setInterval(function(){
		$('#file_copy_progress').load('/file_ops/file_copy_progress?destination_directory=' + directory + '&source_directory_files=' + source_directory_files);
	}, 30000);
}

function check_system_temps(){
	setInterval(function(){
		$('#systemTemps').load('/diagnostics/check_system_temps');
	}, 1000);
}

function close_this_window_in(miliseconds){
	setTimeout (function (){
		window.close();
	}, miliseconds)
}
