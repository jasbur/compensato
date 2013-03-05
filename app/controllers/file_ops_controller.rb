class FileOpsController < ApplicationController

	#Main index action for "file_ops"
	def index
		
	end

	#Hold the passed "@file_op_type" (what the user wnats to do) parameter to determine what to 
	#display in the view
	def new
		@file_op_type = params[:fileOpType]
	end

	#Triggers file scan with given paramters from "new" and displays a 
	#sorted list of all files matching file scan parameters from "file_scan"
	def file_scan
		@extensions = params[:selected_extensions]
		@scan_days = params[:scan_days]
		@log_lines = FileOp.file_scan_20(@scan_days, @extensions)
	end

	#Catches the selected files from "selected_files_log" and saves a simple text log into 
	#/media/compensato_client/Compensato then isolates and sorts them for display
	def selected_files_log
		@selected_paths = params[:selected_paths]
		@extensions = params[:extensions].split
		@scan_days = params[:scan_days]

		FileOp.create_final_scan_log(@selected_paths, @extensions, @scan_days)
	end

	#Control the copying of data from the given directory to another specified directory
	def copy_user_data
		source_directory =params[:source_directory]
		@destination_directory = params[:destination_directory]

		@source_directory_size = FileOp.get_directory_size(source_directory)
		@source_directory_files = FileOp.get_number_of_files(source_directory)

		FileOp.copy_data(source_directory, @destination_directory)
	end

	#To be called periodically from /file_ops/copy_user_data to provide a status update of the file copy
	def file_copy_progress
		@source_directory_size = params[:source_directory_size]
		destination_directory = params[:destination_directory]

		@destination_directory_size = FileOp.get_directory_size(destination_directory)
		@destination_directory_files = FileOp.get_number_of_files(destination_directory)
		
		render :layout => false
	end

	#Kill all instances of the "cp" command running on the system to cancel the current copy operation
	def kill_copy
		FileOp.kill_background_process("cp")
	end

end
