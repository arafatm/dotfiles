# Include tab-completion in irb
require 'irb/completion'
require 'rubygems' 
#require 'wirble' 
require 'awesome_print'
require 'yaml'
require 'pp'
require 'utility_belt'
#require 'soma'

# Load .railsrc
load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']

IRB.conf[:AUTO_INDENT]=true

# start wirble (with color) 
Wirble.init 
Wirble.colorize unless IRB.conf[:PROMPT_MODE] == :INF_RUBY 

# Enable ri 
module RiShortcut
  def self.init
	Kernel.class_eval {
	  def ri(arg)
		puts `ri '#{arg}'`
	  end
	}

	Module.instance_eval {
	  def ri(meth=nil)
		if meth
		  if instance_methods(false).include? meth.to_s
			puts `ri #{self}##{meth}`
		  else
			super
		  end
		else
		  puts `ri #{self}`
		end
	  end
	}
	end
  end


  # Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

# Modify the prompt so it looks nice and tidy. Taken from Programming Ruby 2.
IRB.conf[:IRB_RC] = proc do |conf|
  leader = " " * conf.irb_name.length
  conf.prompt_i = "#{conf.irb_name} --> "
  conf.prompt_s = leader + ' \-" '
  conf.prompt_c = leader + ' \-+ '
  conf.return_format = leader + " ==> %s\n\n"
  puts "Welcome to interactive ruby!"
end

# Load and save each command in irb so we don't have to re-type stuff.  Taken from ctran.
# http://snipplr.com/view/1026/my-irbrc/
HISTFILE = "~/.irb_history"
MAXHISTSIZE = 100

begin
  if defined? Readline::HISTORY
    histfile = File::expand_path( HISTFILE )
    if File::exists?( histfile )
      lines = IO::readlines( histfile ).collect {|line| line.chomp}
      puts "Read %d saved history commands from %s." %
      [ lines.nitems, histfile ] if $DEBUG || $VERBOSE
      Readline::HISTORY.push( *lines )
    else
      puts "History file '%s' was empty or non-existant." %
      histfile if $DEBUG || $VERBOSE
    end

    Kernel::at_exit {
      lines = Readline::HISTORY.to_a.reverse.uniq.reverse
      lines = lines[ -MAXHISTSIZE, MAXHISTSIZE ] if lines.nitems > MAXHISTSIZE
      $stderr.puts "Saving %d history lines to %s." %
      [ lines.length, histfile ] if $VERBOSE || $DEBUG
      File::open( histfile, File::WRONLY|File::CREAT|File::TRUNC ) {|ofh|
        lines.each {|line| ofh.puts line }
      }
    }
  end
end

# In irb, can type:  
# people/6 instead of Person.find(6)  
# That is, can paste in urls into irb to find objects.  
class ModelProxy  
  def initialize(klass)  
    @klass = klass  
  end  
  def /(id)  
    @klass.find(id)  
  end  
end  

def define_model_find_shortcuts  
  model_files = Dir.glob("app/models/**/*.rb")  
  model_names = model_files.map { |f| File.basename(f).split('.')[0..-2].join }  
  model_names.each do |model_name|  
    Object.instance_eval do  
      define_method(model_name.pluralize) do |*args|  
        ModelProxy.new(model_name.camelize.constantize)  
      end  
    end  
  end  
end  


# Use this to find where a method is defined
# >> where_is_this_defined {Streamlined.ui_for(:foo)}
# => "Streamlined received message 'ui_for', Line #6 of /Users/abedra/src/someapp/trunk/lib/extensions/streamlined/streamlined.rb" 
module Kernel

  # which { some_object.some_method() } => ::
  def where_is_this_defined(settings={}, &block)
    settings[:debug] ||= false
    settings[:educated_guess] ||= false

    events = []

    set_trace_func lambda { |event, file, line, id, binding, classname|
      events << { :event => event, :file => file, :line => line, :id => id, :binding => binding, :classname => classname }

      if settings[:debug]
        puts "event => #{event}" 
        puts "file => #{file}" 
        puts "line => #{line}" 
        puts "id => #{id}" 
        puts "binding => #{binding}" 
        puts "classname => #{classname}" 
        puts ''
      end
    }
    yield
    set_trace_func(nil)

    events.each do |event|
      next unless event[:event] == 'call' or (event[:event] == 'return' and event[:classname].included_modules.include?(ActiveRecord::Associations))
      return "#{event[:classname]} received message '#{event[:id]}', Line \##{event[:line]} of #{event[:file]}" 
    end

    if settings[:educated_guess] and events.size > 3
      event = events[-3]
      return "#{event[:classname]} received message '#{event[:id]}', Line \##{event[:line]} of #{event[:file]}" 
    end

    return 'Unable to determine where method was defined.'
  end
end

# Display SQL used
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# start soma
#Soma.start
# vim:ft=ruby:
