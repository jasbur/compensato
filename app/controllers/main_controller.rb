class MainController < ApplicationController

	#Main index for the "main" controller. Also auto-mounts client drive and collects general 
	#system information
	def index
		DriveOp.mount_client_drive
		@system_stats = SystemInfo.get_system_stats
		
		if @system_stats[:hd_capacity].nil? == false
			@drive_percent_used = ((@system_stats[:hd_space_used].to_f / @system_stats[:hd_capacity].to_f) * 100).round
		end
	end

	def system_shutdown
		system "shutdown -h now"
	end

end
