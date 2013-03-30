class DriveOp < ActiveRecord::Base
  # attr_accessible :title, :body

	#Auto-mounts the customer drive by iterating through "mount_iterations", mounting them, then 
	#checking to see if the "pagefile.sys" exists. If it doesn't then it unmounts the drive and 
	#continues to the next item in "mount_iterations"
	def self.mount_client_drive
		mount_iterations = Array.new
		gdisk_output = %x(gdisk /dev/sda -l).split("\n")
		client_drive_found = false

		if Dir.exist?("/media/compensato_client") == false
			Dir.mkdir("/media/compensato_client")
		end

		gdisk_output.each{|line|
			if line.include?("Microsoft basic data")
				mount_iterations << "/dev/sda" + line.split[0]
			end
		}

		unless Dir.entries("/media/compensato_client").size > 2
			mount_iterations.each{|i|
				unless client_drive_found == true
					if system "mount -o remove_hiberfile #{i} /media/compensato_client"
						if File.exist?("/media/compensato_client/pagefile.sys") or File.exist?("/media/compensato_client/PAGEFILE.SYS")
							client_drive_found = true
						else
							sleep 1
							system "umount /media/compensato_client"
						end
					end
				end
			}
		end

		create_client_folder_structure
	end

	#Creates default folder structure on client drive if it doesn't already exist
	def self.create_client_folder_structure
		if Dir.exist?("/media/compensato_client/Compensato") == false
			Dir.mkdir("/media/compensato_client/Compensato")
		end

		if Dir.exist?("/media/compensato_client/Compensato/Downloads") == false
			Dir.mkdir("/media/compensato_client/Compensato/Downloads")
		end

		if Dir.exist?("/media/compensato_client/Compensato/Quarantine") == false
			Dir.mkdir("/media/compensato_client/Compensato/Quarantine")
		end

		if Dir.exist?("/media/compensato_client/Compensato/Customer_Data") == false
			Dir.mkdir("/media/compensato_client/Compensato/Customer_Data")
		end
	end

	#Finds and returns a string of the Linux device ID of the client's drive (only works if
	#client's drive is mounted)
	def self.get_client_device_id
		lines = %x(df).split("\n")
		device_id = String.new

		lines.each{|line|
			if line.include?("/media/compensato_client")
				device_id = line.split.first
			end
		}

		return device_id
	end

	#Triggers a disk check by scheduling a "chkdsk" run on he next boot into Windows
	def self.schedule_disk_check(device_id)
		system "umount /media/compensato_client"
		sleep 1
		system "ntfsfix #{device_id}"
		system "mount #{device_id} /media/compensato_client"
	end

end
