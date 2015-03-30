require 'optparse'

module GitlogMD

  class ArgumentParser

    DEFAULTS = { :output_file => 'HISTORY.md',
                 :branch      => 'master',
                 :repo_dir    => '.',
    }

    def initialize
      @cmd_options = {}

      @optparse = OptionParser.new do | opts |
        # Set a banner
        opts.banner = "Usage: #{File.basename($0)} [options...]"

        opts.on "-o", "--output-file FILE",
                "File to write MarkDown output to",
                "(default #{DEFAULTS[:output_file]})"  do |file|
          @cmd_options[:output_file] = file
        end

        opts.on "-b", "--branch BRANCH",
                "Branch to read git log history from",
                "(default #{DEFAULTS[:branch]})"  do |file|
          @cmd_options[:branch] = file
        end

        opts.on "-r", "--repo-dir DIR",
                "Path to github repo",
                "(default #{DEFAULTS[:repo_dir]})"  do |file|
          @cmd_options[:repo_dir] = file
        end

        opts.on("--version", "Report currently running version of GitlogMD" ) do
          @cmd_options[:version] = true
        end

        opts.on("--help", "Display this screen" ) do
          @cmd_options[:help] = true
        end
      end

    end

    # Parse an array of arguments into a Hash of options, use default values for
    # unset arguments
    # @param [Array] args The array of arguments to consume
    #
    # @example
    #   args = ['--option', 'value', '--option2', 'value2', '--switch']
    #   parser = ArgumentParser.new
    #   parser.parse(args) == {:option => 'value, :options2 => value, :switch => true}
    #
    # @return [Hash] Return the Hash of options
    def parse( args = ARGV )
      @optparse.parse(args)
      DEFAULTS.merge(@cmd_options)
    end

    # Generate a string representing the supported arguments
    #
    # @example
    #    parser = ArgumentParser.new
    #    parser.usage = "Options:  ..."
    #
    # @return [String] Return a string representing the available arguments
    def usage
      @optparse.help
    end

  end
end
