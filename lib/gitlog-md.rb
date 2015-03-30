require 'rubygems' unless defined?(Gem)
module GitlogMD

  %w( version parser argument_parser cli ).each do |lib|
    begin
      require "gitlog_md/#{lib}"
    rescue LoadError
      require File.expand_path(File.join(File.dirname(__FILE__), 'gitlog-md', lib))
    end
  end

end
