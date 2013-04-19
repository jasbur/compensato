class DiskOpsController < ApplicationController

	def index
		
	end

	def new
		@disk_op_type = params[:fileOpType]
		
		if @disk_op_type == "edit_partitions"
			spawn "gparted"
		elsif @disk_op_type == "disk check"
			client_device_id = DriveOp.get_client_device_id
			DriveOp.schedule_disk_check(client_device_id)
		elsif @disk_op_type == "manually_mount_drive"
			@partitions = DriveOp.gdisk_partition_output
		end
	end

end
