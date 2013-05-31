class DriveOp
  # attr_accessible :title, :body

	#Auto-mounts the customer drive by using the output from DriveOp.find_client_partition
	def self.mount_client_drive
		if Dir.exist?("/media/ubuntu/compensato_client") == false
			system "mkdir -p /media/ubuntu/compensato_client"
		end
		
    unless Dir.entries("/media/ubuntu/compensato_client").size > 3
  		client_partition = find_client_partition
      system "mount -o remove_hiberfile /dev/sda#{client_partition} /media/ubuntu/compensato_client"
    end

		create_client_folder_structure
	end

	#Generate output of viable client partitions using gdisk output
	def self.gdisk_partition_output
		gdisk_output = %x(gdisk /dev/sda -l).split("\n")
		partitions = Array.new

		gdisk_output[22..-1].each{|line|
			partitions << line
		}

		return partitions
	end

	#Manually mount the provided device into /media/ubuntu/compensato_client
	def self.manual_drive_mount(device_id)
		system "mount -o remove_hiberfile #{device_id} /media/ubuntu/compensato_client"
	end

	#Finds the largest and therefore most likely to be system partition on the clients system
	#using the output from the "partel -l"
	def self.find_client_partition
	  parted_output = %x(parted -l)
	  biggest_partition_size = 0
	  most_likely_partition = 0
	  
    parted_output.split("\n").each{|line|
      if line.split[3].to_s.include?("GB")
        this_partition_size = line.split[3][0..-3].to_i
        
         if this_partition_size > biggest_partition_size
           biggest_partition_size = this_partition_size
           most_likely_partition = line.split[0]
         end
         
      end
    }
    
    return most_likely_partition
	end
	
	#Creates default folder structure on client drive if it doesn't already exist
	def self.create_client_folder_structure
		if Dir.exist?("/media/ubuntu/compensato_client/Compensato") == false
			Dir.mkdir("/media/ubuntu/compensato_client/Compensato")
		end

		if Dir.exist?("/media/ubuntu/compensato_client/Compensato/Downloads") == false
			Dir.mkdir("/media/ubuntu/compensato_client/Compensato/Downloads")
		end

		if Dir.exist?("/media/ubuntu/compensato_client/Compensato/Quarantine") == false
			Dir.mkdir("/media/ubuntu/compensato_client/Compensato/Quarantine")
		end

		if Dir.exist?("/media/ubuntu/compensato_client/Compensato/Customer_Data") == false
			Dir.mkdir("/media/ubuntu/compensato_client/Compensato/Customer_Data")
		end
	end

	#Finds and returns a string of the Linux device ID of the client's drive (only works if
	#client's drive is mounted)
	def self.get_client_device_id
		lines = %x(df).split("\n")
		device_id = String.new

		lines.each{|line|
			if line.include?("/media/ubuntu/compensato_client")
				device_id = line.split.first
			end
		}

		return device_id
	end

	#Triggers a disk check by scheduling a "chkdsk" run on he next boot into Windows
	def self.schedule_disk_check(device_id)
		system "umount /media/ubuntu/compensato_client"
		sleep 1
		system "ntfsfix #{device_id}"
		system "mount #{device_id} /media/ubuntu/compensato_client"
	end

end
