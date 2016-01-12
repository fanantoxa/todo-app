ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

if ENV.include?('VAGRANT_PORT')
  require 'rails/commands/server'
  module Rails
    class Server
      def default_options
        super.merge(Host: ENV['VAGRANT_PORT'], Port: 3000)
      end
    end
  end
end