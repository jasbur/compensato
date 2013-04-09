class DiagnosticsController < ApplicationController

	def index
		
	end

	#Hold the passed "@diagnostic_type" (what the user wnats to do) parameter to determine what to 
	#display in the view
	def new
		@diagnostic_type = params[:diagnostic_type]

		if @diagnostic_type == "bluescreen_view"
			spawn "sudo -u ubuntu wine ext_apps/bluescreenview/BlueScreenView.exe /MiniDumpFolder z:\\\\media\\\\compensato_client\\\\Windows\\\\Minidump"
		elsif @diagnostic_type == "network_health_test"
			
		end
	end

	#Executes the system's "ping" test with the given params
	def ping_test
		@address_to_ping = params[:address_to_ping]
		@number_of_pings = params[:number_of_pings]

		@ping_results = Diagnostic.ping_test(@address_to_ping, @number_of_pings)
	end

end
