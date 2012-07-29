with_defaults :output => :insert_as_snippet do

	######################################################
	# Loaders
  ######################################################
	
	snippet "Load config" do |s|
	  s.trigger = "+config"
	  s.expansion = '\$this->load->config(\'$1\');$0'
	end
	
	snippet "Load database" do |s|
	  s.trigger = "+db"
	  s.expansion = '\$this->load->database(\'$1\');$0'
	end
	
	snippet "Load database" do |s|
	  s.trigger = "+db"
	  s.expansion = '\$this->load->driver(\'${1:cache}\');$0'
	end
	
	snippet "Load file" do |s|
	  s.trigger = "+file"
	  s.expansion = '\$this->load->file(\'$1\');$0'
	end
	
	snippet "Load helper" do |s|
	  s.trigger = "+helper"
	  s.expansion = '\$this->load->helper(\'${1:/array/captcha/cookie/date/diretory/download/email/file/form/html/inflector/language/number/path/security/smiley/string/text/typography/url/xml}\');$0'
	end
	
	snippet "Load language" do |s|
	  s.trigger = "+lang"
	  s.expansion = '\$this->load->language(\'$1\');$0'
	end
	
	snippet "Load library" do |s|
	  s.trigger = "+library"
	  s.expansion = '\$this->load->library(\'${1:/calendar/cart/driver/email/encrypt/form_validation/ftp/image_lib/javascript/log/pagination/parser/profiler/session/sha1/table/trackback/typography/unit_test/upload/user_agent/xmlrpc/xmlrpcs/zip}\');$0'
	end
	
	snippet "Load model" do |s|
	  s.trigger = "+model"
	  s.expansion = '\$this->load->model(\'$1\');$0'
	end
	
	snippet "Load vars" do |s|
	  s.trigger = "+vars"
	  s.expansion = '\$this->load->vars(${1:\$vars});$0'
	end
	
	snippet "Load view" do |s|
	  s.trigger = "+view"
	  s.expansion = '\$this->load->view(\'$1\', ${2:\$data}, ${3:FALSE/TRUE});$0'
	end
	
	######################################################
	# Templates
  ######################################################
  
	command 'CI File boilerplate' do |cmd|
		cmd.trigger = 'ci_file'
		cmd.invoke do |context|
			filename = ENV['TM_FILENAME']||''
      filename.gsub!(/(.*)\..*/, '\1')
      filename = filename[0,1].capitalize + filename[1..-1]
      username = ENV['TM_FULLNAME']||''
      file = (ENV['TM_FILENAME']||'') + '.php'
      path = '.' + ENV['TM_FILEPATH'][context.project.to_dir.path.length..-1].gsub(/\\/, '/')
'<?php if (!defined(\'BASEPATH\')) exit(\'No direct script access allowed\');

/**
 * ' + "#{filename}" + '
 *
 * @author ' + "#{username}" + '
 * @package ' + "#{context.project.name}" + '
 */

$0

/* End of file ' + "#{file}" + ' */
/* Location: ' + "#{path}" + ' */'
		end
	end
	
	command 'CI Controller boilerplate' do |cmd|
		cmd.trigger = 'ci_controller'
		cmd.invoke do |context|
			filename = ENV['TM_FILENAME']||''
      filename.gsub!(/(.*)\..*/, '\1')
      filename = filename[0,1].capitalize + filename[1..-1]
      username = ENV['TM_FULLNAME']||''
      file = (ENV['TM_FILENAME']||'') + '.php'
      path = '.' + ENV['TM_FILEPATH'][context.project.to_dir.path.length..-1].gsub(/\\/, '/')
'<?php if (!defined(\'BASEPATH\')) exit(\'No direct script access allowed\');

/**
 * ' + "#{filename}" + '
 *
 * @author ' + "#{username}" + '
 * @package ' + "#{context.project.name}" + '
 */
class ' + "#{filename}" + ' extends ${1:CI_Controller} {
  
	/**
	 * Constructor. 
	 */
	function __construct()
	{
	  parent::__construct();
	  log_message(\'debug\', \'' + "#{filename}" + ' initialised\');
	}
	
	function index()
	{
		$0
	}

} 
/* End of file ' + "#{file}" + ' */
/* Location: ' + "#{path}" + ' */'
		end
	end
	
	command 'CI Model boilerplate' do |cmd|
		cmd.trigger = 'ci_model'
		cmd.invoke do |context|
			filename = ENV['TM_FILENAME']||''
			filename.gsub!(/(.*)\..*/, '\1')
			filename = filename[0,1].capitalize + filename[1..-1]
			username = ENV['TM_FULLNAME']||''
			file = (ENV['TM_FILENAME']||'') + '.php'
			path = '.' + ENV['TM_FILEPATH'][context.project.to_dir.path.length..-1].gsub(/\\/, '/')
'<?php if (!defined(\'BASEPATH\')) exit(\'No direct script access allowed\');

/**
 * ' + "#{filename}" + '
 *
 * @author ' + "#{username}" + '
 * @package ' + "#{context.project.name}" + '
 */
class ' + "#{filename}" + ' extends ${1:CI_Model} {
	
	/**
	 * Constructor. 
	 */
	function __construct()
	{
		parent::__construct();
		log_message(\'debug\', \'' + "#{filename}" + ' initialised\');
	}

	$0
} 
/* End of file ' + "#{file}" + ' */
/* Location: ' + "#{path}" + ' */'
		end
	end
	
end