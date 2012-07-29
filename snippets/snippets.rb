with_defaults :output => :insert_as_snippet do

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