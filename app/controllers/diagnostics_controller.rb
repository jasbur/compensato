class DiagnosticsController < ApplicationController

	def index
		
	end

	def new
		@diagnostic_type = params[:diagnostic_type]

		if @diagnostic_type == "bluescreen_view"
			spawn "sudo -u ubuntu wine ext_apps/bluescreenview/BlueScreenView.exe /MiniDumpFolder z:\\\\media\\\\compensato_client\\\\Windows\\\\Minidump"
		elsif @diagnostic_type == "network_health_test"
			
		end
	end

	def ping_test
		number_of_pings = params[:number_of_pings]
		@ping_results = Diagnostic.ping_test(number_of_pings)
	end

end
