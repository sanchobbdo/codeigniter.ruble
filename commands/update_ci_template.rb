$: << File.dirname(__FILE__) + '/../lib/rubyzip/lib'
require 'ruble'
require 'ruble/ui'
require 'zip/zip'
require 'net/http'

class CITemplateUpdater
	
	def initialize(bundle_path)
		@bundle_path = bundle_path
	end
	
	def say_hi
		puts "Template updater"
		puts "Part of a code Igniter Ruble for Aptana"
		puts "By Camilo Aguilar at Nucleo Digital SAS"
		puts ""
		puts "Give Code Igniter some Aptana love"
		puts ""
	end
	
	def check_version
		cv = "0"
		cv_path = @bundle_path + '/templates/version.txt'
		
		if !File.exists?(cv_path)
			puts "Couldn't find your current CI version, updating anyway."
			puts ""
		else
			v = File.open(cv_path)
			cv = v.read
			v.close
			
			puts "Your current CI version is " + cv
		end
		
		res = Net::HTTP.get_response URI('http://versions.ellislab.com/codeigniter_version.txt')
		rv = res.body
		
		puts "Lastest stable CI version is " + rv
		
		a1 = cv.split('.').map{|s|s.to_i}
		a2 = rv.split('.').map{|s|s.to_i}
		
		if (a1 <=> a2) == 0
			continue = Ruble::UI.request_confirmation(
				:title => "You're CI installation is up to date, do you wish to continue?",
				:prompt => "You're CI installation is up to date, do you wish to continue?",
				:button1 => 'Yes',
				:button2 => 'No'
			)
			
			if !continue
				puts "So ... that's it then, bye!"
				exit
			end
		end
		
		puts ""
		
		@version = rv
	end
	
	def update
		temp_path = @bundle_path + '/tmp'
		
		puts "Prepering ..."
		
		if !File.directory? temp_path
			Dir.mkdir temp_path
		end
		
		puts "Downloading (be patient) ..."

		Net::HTTP.start("downloads.codeigniter.com") do |http|
	    resp = http.get("/reactor/CodeIgniter_" + @version + ".zip")
	    open(temp_path + '/downloaded.zip', "wb") do |file|
	        file.write(resp.body)
	        file.close
	    end
  	end
  	
  	puts "Tweakin' and modifiyn' ..."
  	
  	dest = @bundle_path + '/templates/ci.zip'
  	if File.exists? dest
  		File.delete dest
  	end
  	
  	Zip::ZipOutputStream::open(dest) { 
		  |cizip|
			
			Zip::ZipInputStream::open(temp_path + "/downloaded.zip") {
			  |downloaded|
			
			  while (entry = downloaded.get_next_entry)
			  	new_name = '.' + entry.name[("CodeIgniter_" + @version).length..-1]
			  	if new_name[-1, 1] != '/' && new_name[0.."./user_guide".length - 1] != "./user_guide"
				  	cizip.put_next_entry(new_name)
				  	cizip.write(downloaded.read)
			   end
			  end
			}
			
			open(@bundle_path + '/templates/.htaccess') do |ht|
				cizip.put_next_entry(".htaccess")
				cizip.write(ht.read)
			end
			# TODO add .htaccess
			
		}
		
		if File.exists?(@bundle_path + '/templates/version.txt')
			File.delete @bundle_path + '/templates/version.txt'
		end
		
		puts "Updating version ..."
		open(@bundle_path + '/templates/version.txt', 'w') do |file|
			file.write @version
		end
		
		puts "Cleaning up ..."
		FileUtils.rm_rf(temp_path)
		
		puts ""
  	
	end
	
	def say_bye
		puts "Said and done, Code Igniter is under control."
		puts "To enjoy: File > New ... > Web Project > Next > Code Igniter template"
	end
end

command 'Update CI template' do |cmd|
	cmd.output = :output_to_console
	cmd.input = :none
	cmd.working_directory = :current_bundle
	cmd.invoke do |context|
		bundle_path = ENV['TM_BUNDLE_PATH']
		updater = CITemplateUpdater.new bundle_path
		updater.say_hi
		updater.check_version
		updater.update
	end
end
