require "./rbrain"

def process_argv(option)
  case option
    when "-h", "--help"
      puts "usage: ruby main.rb [-h] [-v] file_name"
      puts ""
      puts "positional arguments:"
      puts "  file_name      brainfuck source code file"
      puts ""
      puts "optional arguments:"
      puts "  -h, --help     show this help message and exit"
      puts "  -v, --version  print version number on screen and exit"
      exit
    when "-v", "--version"
      puts "ruby-brain version 0.0.1 - Ruby BrainFuck Interpreter"
      exit
    else
      @options[:file_name] = option
  end
end

@options = {}

ARGV.each { |option| process_argv(option) }

code = File.read(@options[:file_name])

bf = BrainFuck.new(code)

bf.execute
