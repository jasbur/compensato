class SystemInfo < ActiveRecord::Base
  
	def self.get_system_stats
		system_stats = []
		cpu_info = %x(cat /proc/cpuinfo).split("\n")
		mem_info = %x(cat /proc/meminfo).split("\n")
		drive_info = %x(df).split("\n")
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
				system_stats << line.split[3]
			end
		}

		drive_info.each{|line|
			if line.include?("/media/compensato_client")
				system_stats << line.split[2]
			end
		}

		return system_stats
	end

end
