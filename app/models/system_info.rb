class SystemInfo
  
	#Gets the system information for the desired attributes and returns them as an ordered array of strings
	def self.get_system_stats
		system_stats = Hash.new
		cpu_info = %x(cat /proc/cpuinfo).split("\n")
		mem_info = %x(cat /proc/meminfo).split("\n")
		drive_info = %x(df).split("\n")
		hd_id = DriveOp.get_client_device_id
		ip_info = %x(ifconfig).split("\n")
		smartctl_ouput = %x(smartctl -a #{hd_id}).split("\n")

		#Grab CPU info from /proc/cpuinfo
		cpu_info.each{|line|
			if line.include?("model name")
				system_stats.merge!(:cpu_model => line[13..-1])
				break
			end
		}

		cpu_info.each{|line|
			if line.include?("cpu cores")
				system_stats.merge!(:cpu_cores => line.split[3])
				break
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


		smartctl_ouput.each{|line|
			if line.include?("FAILING_NOW")
				system_stats.merge!(:smart_health => "Imminent failure")
				break
			elsif line.include?("Pre-fail")
				system_stats.merge!(:smart_health => "Pre-fail")
				break
			else
				system_stats.merge!(:smart_health => "Healthy")
			end
		}

		ip_info.each{|line|
			if line.include?("inet addr:") and line.include?("127.0.0.1") == false
				# system_stats << "hello	"
				system_stats.merge!(:ip_address => line.split(" ")[1][5..-1])
			end
		}

		return system_stats
	end

	def self.check_for_running_process(process)
		ps_output = %x(ps -e)
		process_runnning = false

		if ps_output.include?(" #{process}\n")
			process_runnning = true
		end

		return process_runnning
	end

end
