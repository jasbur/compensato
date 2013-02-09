class FileOpsController < ApplicationController

	def index
		
	end

	def new
		@file_op_type = params[:fileOpType]
	end

	def create

	end

	def show

	end

	def edit
		
	end

	def update
		
	end

	def destroy
		
	end

	def file_scan
		@extensions = params[:selected_extensions]
		scan_days = params[:scan_days]
		@log_lines = FileOp.file_scan_20(scan_days, @extensions)
	end

	def selected_files_log
		@selected_paths = params[:selected_paths]
		@extensions = params[:extensions].split
		FileOp.create_final_scan_log(@selected_paths, @extensions)
	end

end
