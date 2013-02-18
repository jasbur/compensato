class DownloadsController < ApplicationController

	def index
		combofix_url = Download.get_combofix_url
		@file_links = {"ComboFix" => combofix_url, 
			"TDSSKiller" => "http://support.kaspersky.com/downloads/utils/tdsskiller.exe", 
			"Malwarebytes" => "http://ninite.com/malwarebytes/ninite.exe", 
			"Google Chrome" => "http://ninite.com/chrome/ninite.exe"}
	end

	def fetch_downloads
		pre_hash_download_links = params[:download_links]
		download_links = Hash.new

		pre_hash_download_links.each{|pre_hash_download_link|
			pair = pre_hash_download_link.split("|")
			download_links[pair[0]] = pair[1]
		}

		Download.download_files_to_client(download_links)
	end

end
