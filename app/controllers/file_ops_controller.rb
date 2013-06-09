class FileOpsController < ApplicationController

	#Main index action for "file_ops"
	def index
		
	end

	#Hold the passed "@file_op_type" (what the user wnats to do) parameter to determine what to 
	#display in the view
	def new
		@file_op_type = params[:file_op_type]
		@temp_files_size = 0

		if @file_op_type == "clean_temp_files"
			@temp_files_size = FileOp.get_temp_files_size
		elsif @file_op_type == "folder_usage_display"
			spawn "baobab /media/ubuntu/compensato_client"
		elsif @file_op_type == "view_ie_browser_history"
		  @users = FileOp.get_all_windows_users
		elsif @file_op_type == "complete_folder_copy"

		end
	end

	#Triggers file scan with given paramters from "new" and displays a 
	#sorted list of all files matching file scan parameters from "file_scan"
	def file_scan
		@extensions = params[:selected_extensions]
		@scan_days = params[:scan_days]
		@log_lines = FileOp.file_scan_20(@scan_days, @extensions)
	end

	#Catches the selected files from "selected_files_log" and saves a simple text log into 
	#/media/ubuntu/compensato_client/Compensato then isolates and sorts them for display
	def selected_files_log
		selected_paths = params[:selected_paths]
		@extensions = params[:extensions].split
		@scan_days = params[:scan_days]

		@selected_file_objects = FileOp.create_file_object_array(selected_paths)
		@selected_file_objects.sort! {|a,b| a.mtime <=> b.mtime}
		FileOp.create_final_scan_log(@selected_file_objects, @extensions, @scan_days)
	end

	#Produces a log showing files of all types modified for the provided date range
	def all_files_modified_on_date
		@start_date = params[:start_date]
		calc_end_date = Time.new("#{@start_date.split('-')[0]}", "#{@start_date.split('-')[1]}", "#{@start_date.split('-')[2]}")
		end_date = (calc_end_date + 86400).to_s[0..9]

		@selected_file_name = params[:selected_file_name]

		file_paths = FileOp.find_all_files_on_date(@start_date, end_date)
		@file_objects = FileOp.create_file_object_array(file_paths)
		@file_objects.sort! {|a,b| a.mtime <=> b.mtime}
	end

	#Control the copying of data from the given directory to another specified directory
	def migrate_user_data
		source_directory = params[:source_directory]
		@destination_directory = params[:destination_directory]

		@source_directory_size = FileOp.get_directory_size(source_directory)
		@source_directory_files = FileOp.get_number_of_files(source_directory)

		@copy_pid = FileOp.copy_data(source_directory, @destination_directory)
	end

	#Cleans temp files from common locations on the client's drive
	def clean_temp_files
		FileOp.clean_temp_files
	end

	#To be called periodically from /file_ops/copy_user_data to provide a status update of the file copy
	def file_copy_progress
		@source_directory_files = params[:source_directory_files]
		destination_directory = params[:destination_directory]

		@destination_directory_size = FileOp.get_directory_size(destination_directory)
		@destination_directory_files = FileOp.get_number_of_files(destination_directory)

		@process_running = SystemInfo.check_for_running_process("cp")
		
		render :layout => false
	end

	#Kill all instances of the "cp" command running on the system to cancel the current copy operation
	def kill_copy
		FileOp.kill_background_process("cp")
	end

  #Triggers a Nautilus file browser window to open displaying the containing folder of the specified file. If
  #the "full_path" is given (which includes a file name at the end) the file name is eliminated first. If a
  #"directory parameter is given it's just passed on to FileOp.launch_nautilus as-is"
  def open_file_browser
    full_path = params[:full_path]
    directory = params[:directory]
    
    if full_path.nil?
      FileOp.launch_nautilus(Regexp.escape(directory))
    else
      file_name = full_path.split("/").last
      FileOp.launch_nautilus(Regexp.escape(full_path.gsub(file_name, "")))
    end
    
  end

  def launch_iehv
    user = params[:user]
    
    FileOp.launch_iehv(user)
  end

  def folder_browser
    user_selected_directory = params[:user_selected_directory]
    puts "USER SELECTED IS: #{user_selected_directory}"
    
    @base_directory = ""
    
    if user_selected_directory.nil?
      @base_directory = "/media/ubuntu"
    else
      @base_directory = user_selected_directory
    end
    
    @previous_directory = @base_directory.gsub(@base_directory.split("/").last, "")[0..-2]    
    
    directories = Dir.entries(@base_directory)
      
    directories = directories - [".", ".."]
    @browser_directories = Array.new
    
    directories.each{|dir|
      if File.directory?("#{@base_directory}/#{dir}")
        d_ob = Dir.open("#{@base_directory}/#{dir}")
        
        @browser_directories << d_ob
      end
    }
      
    render :layout => false
  end

end
