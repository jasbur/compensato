class MainController < ApplicationController

	#Main index for the "main" controller. Also auto-mounts client drive and collects general 
	#system information
	def index
		FileOp.mount_client_drive
		@system_stats = SystemInfo.get_system_stats
		@drive_percent_used = ((@system_stats[4].to_f / @system_stats[3].to_f) * 100).round
	end

end
