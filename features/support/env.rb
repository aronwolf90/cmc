# frozen_string_literal: true

require "cucumber/rails"
require "cucumber/rspec/doubles"
require "selenium-webdriver"

ActionController::Base.allow_rescue = false

Cucumber::Rails::Database.javascript_strategy = :truncation
Cucumber::Rails::Database.autorun_database_cleaner = false

Capybara.server_host = "0.0.0.0"
Capybara.server_port = Settings.test_port
Capybara.app_host = "http://#{Settings.test_host}:#{Settings.test_port}"
Capybara.javascript_driver = :selenium
Capybara.default_max_wait_time = 20
Capybara.run_server = ENV["CAPYBARA_RUN_SERVER"] == "true" if ENV["CAPYBARA_RUN_SERVER"].present?

Capybara.register_driver :selenium do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 100

  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { "w3c" => false, args: ["disable-dev-shm-usage"] }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub",
    http_client: client,
    desired_capabilities: capabilities
  )
end

Capybara.server = :puma # Until your setup is working
Capybara.server = :puma, { Silent: true } # To clean up your test output

After do |scenario|
  next unless scenario.failed?

  page.save_screenshot(Rails.root.join("screenshots/error.png"))
  STDERR.puts page.driver.browser.manage.logs.get(:browser)
  Cucumber.wants_to_quit = true
end
