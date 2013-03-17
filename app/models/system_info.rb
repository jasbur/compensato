class SystemInfo < ActiveRecord::Base
  
	#Gets the system information for the desired attributes and returns them as an ordered array of strings
	def self.get_system_stats
		system_stats = Hash.new
		cpu_info = %x(cat /proc/cpuinfo).split("\n")
		mem_info = %x(cat /proc/meminfo).split("\n")
		drive_info = %x(df).split("\n")
		hd_id = DriveOp.get_client_device_id
		ip_info = %x(ifconfig).split("\n")
		#This will be used to dectect duplicate entries when cat'ing /proc
		detect_duplicate = 0

		#Grab CPU info from /proc/cpuinfo
		cpu_info.each{|line|
			if line.include?("model name")
				if detect_duplicate == 0
					system_stats.merge!(:cpu_model => line[13..-1])
					detect_duplicate = 1
				end
			end
		}

		detect_duplicate = 0

		cpu_info.each{|line|
			if line.include?("cpu cores")
				if detect_duplicate == 0
					system_stats.merge!(:cpu_cores => line.split[3])
					detect_duplicate = 1
				end
			end
		}

		mem_info.each{|line|
			if line.include?("MemTotal")
				system_stats.merge!(:mem_total => line.split[1])
			end
		}

		drive_info.each{|line|
			if line.include?("/media/compensato_client")
				capacity = line.split[2].to_i + line.split[3].to_i
				system_stats.merge!(:hd_capacity => capacity)
			end
		}

		drive_info.each{|line|
			if line.include?("/media/compensato_client")
				system_stats.merge!(:hd_space_used => line.split[2])
			end
		}

		system_stats.merge!(:smart_health => %x(smartctl #{hd_id} -H).split.last)

		ip_info.each{|line|
			if line.include?("inet addr:") and line.include?("127.0.0.1") == false
				# system_stats << "hello	"
				system_stats.merge!(:ip_address => line.split(" ")[1][5..-1])
			end
		}

		return system_stats
	end

end
