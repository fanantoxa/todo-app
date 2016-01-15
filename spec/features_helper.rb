require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'
require 'site_prism'
require 'headless'

Dir[Rails.root.join("spec/support/helpers/features/**/*.rb")].each {|f| require f }
Dir[Rails.root.join("spec/support/sections/**/*.rb")].each {|f| require f }
Dir[Rails.root.join("spec/support/pages/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end

if !RUBY_PLATFORM.downcase.include?('darwin') && !ENV['NO_HEADLESS']
  headless = Headless.new
  headless.start
end