class DownloadsController < ApplicationController

	def index
		@combofix_url = Download.get_combofix_url
	end

	def fetch_downloads
		download_links = params[:download_links]
		Download.download_files_to_client(download_links)
	end

end
