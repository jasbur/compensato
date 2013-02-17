class Download < ActiveRecord::Base
  # attr_accessible :title, :body

	#Isolates the dynamically geberated ComboFix URL from the download page by finding predicatable 
	#pattern in the source.
	def self.get_combofix_url
		full_source = %x(curl -s -L http://www.bleepingcomputer.com/download/combofix/dl/12/)
		start_index = full_source.index("<a href='http://download.bleepingcomputer.com/dl/") + 9
		end_index = start_index + 132
		isolated_link = full_source[start_index..end_index]

		return isolated_link
	end

	def self.download_files_to_client(download_links)
		download_links.each{|download_link|
			file_name = download_link.split("/").last
			system "curl -o /media/compensato_client/Compensato/Downloads/#{file_name} #{download_link}"
		}
	end

end
