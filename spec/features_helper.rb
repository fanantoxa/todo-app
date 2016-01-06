require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'
require 'site_prism'
require 'pry'

Dir[Rails.root.join("spec/support/helpers/features/**/*.rb")].each {|f| require f }
Dir[Rails.root.join("spec/support/sections/**/*.rb")].each {|f| require f }
Dir[Rails.root.join("spec/support/pages/**/*.rb")].each {|f| require f }