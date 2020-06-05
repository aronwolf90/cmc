#!/usr/bin/env ruby

require "rubygems"
require "capybara"
require "capybara/dsl"
require "selenium-webdriver"
require "rest-client"

Capybara.run_server = false
Capybara.current_driver = :selenium
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

include Capybara::DSL

RestClient.delete(
  'https://ticktensio.com/api/v1/test_organizations'
)
visit("https://about.ticktensio.com/")
click_on "Register"
fill_in "Name", with: "test-organization"
select "(GMT+01:00) Berlin", from: "Time zone"
fill_in "Firstname", with: "Lara"
fill_in "Lastname", with: "Croft"
fill_in "Email", with: "test@ticktensio.com"
fill_in "Password", with: "testtest"
fill_in "Confirmation password", with: "testtest"
check "Terms of service"
click_on "Create Registration"
fill_in "Email", with: "test@ticktensio.com"
fill_in "Password", with: "testtest"
click_button "Login"
raise "not loged in" unless page.has_text?("Dashboard")
