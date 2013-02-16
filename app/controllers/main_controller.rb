class MainController < ApplicationController

	#Main display action, also auto-mounts client drive
	def index
		FileOp.mount_client_drive
	end

end
