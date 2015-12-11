$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'bot'
require 'web'

Thread.new do
  begin
    Bot::App.instance.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run Bot::Web
