class Diagnostic

	#Uses the system 'ping' command to stress test the network by sending a supplied number of 
	#packets to a specified address and returning a hash of the relevant results
	def self.ping_test(address_to_ping, number_of_pings)
		ping_results = Hash.new

		these_results = %x(ping -fq #{address_to_ping} -c #{number_of_pings}).split("\n")

		these_results.each{|line|
			if line.include?("packet loss")
				ping_results.merge!(:packet_loss_percentage => line.split(" ")[5][0..-2])
			elsif line.include?("rtt")
				ping_results.merge!(:rtt_min => line.split("/")[3][7..-1])
				ping_results.merge!(:rtt_avg => line.split("/")[4])
				ping_results.merge!(:rtt_max => line.split("/")[5])
			end
		}

		return ping_results
	end

	def self.get_system_temps
		sensors_output = %x(sensors).split("\n")
		system_temps = Hash.new
		
		sensors_output.each{|line|
			if line.include?("Core 0")
				system_temps.merge!(:core_0 => line)
			elsif line.include?("Core 1")
				system_temps.merge!(:core_1 => line)
			elsif line.include?("Core 2")
				system_temps.merge!(:core_2 => line)
			elsif line.include?("Core 3")
				system_temps.merge!(:core_3 => line)
			elsif line.include?("Core 4")
				system_temps.merge!(:core_4 => line)
			elsif line.include?("Core 5")
				system_temps.merge!(:core_5 => line)
			elsif line.include?("Core 6")
				system_temps.merge!(:core_6 => line)
			elsif line.include?("Core 7")
				system_temps.merge!(:core_7 => line)
			end
		}

		return system_temps
	end

end
