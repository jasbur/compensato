class MainController < ApplicationController

	#Main display action, also auto-mounts client drive
	def index
		FileOp.mount_client_drive
		@system_stats = SystemInfo.get_system_stats
		@drive_percent_used = ((@system_stats[4].to_f / @system_stats[3].to_f) * 100).round
	end

end
