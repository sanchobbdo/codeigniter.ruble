require 'ruble'

bundle do |bundle| 
	bundle.display_name = 'CodeIgniter'
	bundle.associate_file_type('*.php')
	
	bundle.menu 'CodeIgniter' do |m|	
		m.command 'CI Controller boilerplate'
		m.command 'CI Model boilerplate'
		m.separator
		m.command 'Update CI template'
	end
end