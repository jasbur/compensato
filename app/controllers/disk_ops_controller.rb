class DiskOpsController < ApplicationController

	def index
		
	end

	def new
		@disk_op_type = params[:disk_op_type]
		
		if @disk_op_type == "edit_partitions"
			spawn "gparted"
			render :layout => false
		elsif @disk_op_type == "disk check"
			client_device_id = DriveOp.get_client_device_id
			DriveOp.schedule_disk_check(client_device_id)
		elsif @disk_op_type == "manually_mount_drive"
			@partitions = DriveOp.get_client_partitions
		elsif @disk_op_type == "mount_specific_drive"
			device_id = params[:device_id]

			DriveOp.manual_drive_mount(device_id)

			redirect_to :controller => "main", :action => "index"
		end
	end

end
