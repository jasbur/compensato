class FileOp < ActiveRecord::Base
  # attr_accessible :title, :body

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

	#Uses the systems 'find' command to find all files in a given date range and returns an 
	#array of their paths
	def self.find_all_files_on_date(start_date, end_date)
		system "touch tmp/start_search -d #{start_date}"
		system "touch tmp/end_search -d #{end_date}"

		file_paths = %x(find /media/compensato_client/ -type f -newer tmp/start_search -not -newer tmp/end_search).split("\n")

		system "rm tmp/start_search"
		system "rm tmp/end_search"

		return file_paths
	end

	#Issue a simple "cp" command to copy data using the given directories
	def self.copy_data(source_directory, destination_directory)
		spawn "cp -a '#{source_directory}' '#{destination_directory}'"
	end

	#This process cleans disposable tmeorary files on the client's system. These disposable 
	#direcotries are listed as two arrays, one for user specific driectories and another for 
	#common system-wide directories
	def self.clean_temp_files
		user_directories = Dir.entries("/media/compensato_client/Documents\ and\ Settings")
		garbage_directory_entries = [".", "..", "desktop.ini", "Public", "All Users"]
		user_specific_temp_directories = ["Local Settings/Temp", "Local Settings/Temporary Internet Files"]
		system_temp_directories = ["Windows/Temp"]
		
		user_directories = user_directories - garbage_directory_entries

		user_directories.each{|user_directory|
			user_specific_temp_directories.each{|user_specific_temp_directory|
				system "rm -rf /media/compensato_client/Documents\\ and\\ Settings/" + Regexp.escape(user_directory) + "/" + Regexp.escape(user_specific_temp_directory) + "/*"
			}
		}

		system_temp_directories.each{|system_temp_directory|
			system "rm -rf /media/compensato_client/" + Regexp.escape(system_temp_directory) + "/*"
		}
	end

	#Calculates the total size in bytes of the temp files on the client's system
	def self.get_temp_files_size
		user_directories = Dir.entries("/media/compensato_client/Documents\ and\ Settings")
		garbage_directory_entries = [".", "..", "desktop.ini", "Public", "All Users"]
		user_specific_temp_directories = ["Local Settings/Temp", "Local Settings/Temporary Internet Files"]
		system_temp_directories = ["Windows/Temp"]
		total_temp_files_size = 0
		
		user_directories = user_directories - garbage_directory_entries

		user_directories.each{|user_directory|
			user_specific_temp_directories.each{|user_specific_temp_directory|
				this_dir_size = %x(du -s /media/compensato_client/Documents\\ and\\ Settings/#{Regexp.escape(user_directory)}/#{Regexp.escape(user_specific_temp_directory)}/)
				total_temp_files_size = total_temp_files_size + this_dir_size.to_i
			}
		}

		system_temp_directories.each{|system_temp_directory|
			this_dir_size = %x(du -s /media/compensato_client/#{Regexp.escape(system_temp_directory)}/)
			total_temp_files_size = total_temp_files_size + this_dir_size.to_i
		}

		return total_temp_files_size
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

	#Creates an array of File objects from an array of given paths in String form
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
