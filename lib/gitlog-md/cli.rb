module GitlogMD
  class CLI
       VERSION_STRING = "
                          _________
                         {_________}
                          )=======(
                         /         \\
        GitlogMD        | _________ |
            %10s  ||   _     ||
                        ||  |_)    ||
                        ||  | \\/   ||
                  __    ||    /\\   ||
             __  (_|)   |'---------'|
            (_|)        `-.........-'
"

    def initialize
      @arg_parser = GitlogMD::ArgumentParser.new
      @options = @arg_parser.parse
      @run = true

      if @options[:help]
        puts @arg_parser.usage
        @run = false
        return
      end
      if @options[:version]
        puts VERSION_STRING % GitlogMD::Version::STRING
        @run = false
        return
      end
    end

    def execute
      if @run
        GitlogMD::Parser.new.make_md(@options)
      end
    end

  end
end
