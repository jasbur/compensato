class Diagnostic

	def self.ping_test(number_of_pings)
		ping_results = Hash.new

		these_results = %x(ping -fq 192.168.1.1 -c #{number_of_pings}).split("\n")

		these_results.each{|line|
			if line.include?("packet loss")
				ping_results.merge!(:packet_loss_percentage => line.split(" ")[5][0..-2])
			elsif line.include?("rtt")
				ping_results.merge!(:rtt_min => line.split("/")[3][7..-1])
				ping_results.merge!(:rtt_avg => line.split("/")[4])
				ping_results.merge!(:rtt_max => line.split("/")[5])
			end
		}

		return ping_results
	end

end
