class FileOp < ActiveRecord::Base
  # attr_accessible :title, :body

	#Auto-mounts the customer drive by iterating through "mount_iterations", mounting them, then 
	#checking to see if the "pagefile.sys" exists. If it doesn't then it unmounts the drive and 
	#continues to the next item in "mount_iterations"
	def self.mount_client_drive
		mount_iterations = ["sda1", "sda2", "sda3", "sda4", "sda5", "sda6", "sda7", "sda8", "sda9"]
		client_drive_found = false

		if Dir.exist?("/media/compensato_client") == false
			Dir.mkdir("/media/compensato_client")
		end

		unless Dir.entries("/media/compensato_client").size > 2
			mount_iterations.each{|i|
				unless client_drive_found == true
					if system "mount /dev/#{i} /media/compensato_client"
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

	#Uses the system's "find" command to create a list of files maching the modified time given 
	#then filters them for unwanted files and to make sure they match the appropriate extensions
	def self.file_scan_20(entered_scan_days, extensions)
		full_file_list = %x(find /media/compensato_client/ -type f -mtime -#{entered_scan_days}).split("\n")
		lines_to_return = Array.new
		
		full_file_list.each{|line|	
			if check_for_garbage_file_names(line) == false and check_for_appropriate_file_type(line, extensions) == true
				lines_to_return << line.chomp
			end
		}
		
		return lines_to_return
	end

	#Issue a simple "cp" command to copy data using the given directories
	def self.copy_data(source_directory, destination_directory)
		spawn "cp -a '#{source_directory}' '#{destination_directory}'"
	end

	#Get the directory size using the system's "du" (-s = silent) command
	def self.get_directory_size(directory)
		directory_size = %x(du -s #{Regexp::escape(directory)}).split.first
		return directory_size
	end

	#Gets the number of files in a directory and its sub-directories by using the system's 
	#"find" (-type f = find all files only) command to find all files then pass them to the 
	#"wc" (-l = return only the number of new lines generated) command wich generates a newline 
	#for each one then counts it
	def self.get_number_of_files(directory)
		number_of_files = %x(find #{Regexp::escape(directory)} -type f | wc -l)
		return number_of_files
	end

	#Return "true" if the given string matches any of the "garbage strings"
	def self.check_for_garbage_file_names(file_string)
		garbage_strings = [".pf", "Windows/assembly/GAC/Microsoft.DirectX", "/Windows/assembly/NativeImages", 
							"/Windows/Microsoft.NET/assembly/GAC", "/Windows/winsxs/x86_microsoft"]
		
		garbage_strings.each{|gs|
			if file_string.downcase.include?(gs.downcase)
				return true
			end
		}
		
		return false
	end

	#Checks the last 4 chracters to see if they contain any of the given file extensions by flipping 
	#the string and checking the FIRST 4 chracters for the reverse of the given extensions.
	def self.check_for_appropriate_file_type(file_string, extensions)
		extensions.each{|e|
			if file_string.split(".").last.downcase.include?("#{e}")
				return true
			end
		}
	end

	def self.create_file_object_array(paths)
		file_objects = Array.new

		paths.each{|path|
			file_objects << File.open(path, "r")
		}

		return file_objects
	end

	#Generates a simple text log to be saved on the client's computer conatainging the 
	#technician-selected files only from the "file_scan" output
	def self.create_final_scan_log(file_objects, extensions, scan_days)
		final_scan_log = File.open("/media/compensato_client/Compensato/scanlog_#{Time.now.to_s.gsub(":", "-")}.txt", "w+")

		extensions.each{|extension|
			final_scan_log.puts "######################################################"
			final_scan_log.puts "####### .#{extension} files modified in the last #{scan_days} days ######"
			final_scan_log.puts "######################################################"
			final_scan_log.puts
			final_scan_log.puts "       Modified at:       |       Path:"
			final_scan_log.puts "______________________________________________________"
			final_scan_log.puts

			file_objects.each{|file_object|
				if file_object.path.include?(".#{extension}")
					formatted_path = file_object.path.gsub("/media/compensato_client", "")
					formatted_path.gsub!("/", "\\")

					final_scan_log.puts "#{file_object.mtime} | C:#{formatted_path}"
				end
			}

			final_scan_log.puts
			final_scan_log.puts
		}

		final_scan_log.close
	end

	#Issues a simple "killall" command to kill all processes with the given process name.
	def self.kill_background_process(process)
		system "killall #{process}"
	end

end
