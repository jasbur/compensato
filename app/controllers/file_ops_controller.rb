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
		@extensions = ["exe", "sys"]
		scan_days = params[:scan_days]
		@log_lines = FileOp.file_scan_20(scan_days, @extensions)
	end

end
