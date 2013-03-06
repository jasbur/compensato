class SystemInfo < ActiveRecord::Base
  
	#Gets the system information for the desired attributes and returns them as an ordered array of strings
	def self.get_system_stats
		system_stats = []
		cpu_info = %x(cat /proc/cpuinfo).split("\n")
		mem_info = %x(cat /proc/meminfo).split("\n")
		drive_info = %x(df).split("\n")
		ip_info = %x(ifconfig).split("\n")
		#This will be used to dectect duplicate entries when cat'ing /proc
		detect_duplicate = 0

		#Grab CPU info from /proc/cpuinfo
		cpu_info.each{|line|
			if line.include?("model name")
				if detect_duplicate == 0
					system_stats << line[13..-1]
					detect_duplicate = 1
				end
			end
		}

		detect_duplicate = 0

		cpu_info.each{|line|
			if line.include?("cpu cores")
				if detect_duplicate == 0
					system_stats << line.split[3]
					detect_duplicate = 1
				end
			end
		}

		mem_info.each{|line|
			if line.include?("MemTotal")
				system_stats << line.split[1]
			end
		}

		drive_info.each{|line|
			if line.include?("/media/compensato_client")
				capacity = line.split[2].to_i + line.split[3].to_i
				system_stats << capacity
			end
		}

		drive_info.each{|line|
			if line.include?("/media/compensato_client")
				system_stats << line.split[2]
			end
		}

		ip_info.each{|line|
			if line.include?("inet addr:")
				ip_address = line.split(" ")[1][5..-1]
				unless ip_address.include?("127.0.0.1")
					system_stats << ip_address
				end
			end
		}

		return system_stats
	end

end
