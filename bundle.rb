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
	
	project_template "CodeIgniter Template" do |t|
		t.type = :web
		t.location = "templates/ci.zip"
		t.description = "CodeIgniter template"
		t.replace_parameters = false
	end
end