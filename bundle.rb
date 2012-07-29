require 'ruble'

bundle do |bundle| 
	bundle.display_name = 'CodeIgniter'
	bundle.associate_file_type('*.php')
	
	bundle.menu 'CodeIgniter' do |m|
		m.command 'CI File boilerplate'
		m.command 'CI Controller boilerplate'
		m.command 'CI Model boilerplate'
		m.separator
		m.command 'Load config'
		m.command 'Load database'
		m.command 'Load file'
		m.command 'Load helper'
		m.command 'Load language'
		m.command 'Load library'
		m.command 'Load model'
		m.command 'Load vars'
		m.command 'Load view'
		m.separator
		m.command 'Update CI template'
	end
end