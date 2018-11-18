require "rubygems"
require "bundler"
require "yaml"
require "spork"
require "headless"
require "rspec"
require "page-object"
require "require_all"
require "capybara/rspec"
require "capybara/dsl"
require "capybara/cucumber"
require "selenium-webdriver"
require "fileutils"
require_relative "utils"
require_relative "constants"

begin
  require_all "features/support/pages"
  require_all "features/support/classes"

  def load_config
    config = YAML.safe_load(File.open("config.yaml"))
    config.each do |k, v|
      ENV[k] = v.to_s
    end
  end

  Spork.prefork do
    load_config
  end

  # Initialising capybara
  Utils.log_message('Initialising Capybara setup started....... \n')
  Utils.log_message('UI mode activating...... \n')
  Utils.move_old_screenshots

  Capybara.configure do |config|
    config.default_driver = :selenium
    config.run_server = false
    config.default_selector = :css
    config.default_max_wait_time = 30
    config.app_host = ENV["BASE_URL"]
  end
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.javascript_driver = :chrome
  # Capybara setup
  Utils.log_message("Initialising Capybara setup completed....... \n")
rescue StandardError
  raise "Capybara setup failed.. "
end
