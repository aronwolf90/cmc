#!/usr/bin/env ruby

require "rubygems"
require "capybara"
require "capybara/dsl"
require "selenium-webdriver"
require "rest-client"
require "net/imap"

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
imap = Net::IMAP.new('imap.migadu.com', 993, true)
imap.authenticate('LOGIN', 'test@ticktensio.com', ENV["TESTUSER_PASSWORD"])
imap.examine('INBOX')

RestClient.delete(
  'https://ticktensio.com/api/v1/test_organizations'
)

visit("https://about.ticktensio.com/")
click_on "Register"
imap = Net::IMAP.new('imap.migadu.com', ssl: true)
imap.authenticate('LOGIN', 'test@ticktensio.com', ENV["TESTUSER_PASSWORD"])
imap.examine('INBOX')
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
click_on "Tickets"
find(".list-issue a", match: :prefer_exact).click
find("label", text: "Complexity", match: :prefer_exact)

15.times do |time|
  email_id = imap.search(["UNSEEN"]).last
  if email_id.nil?
    sleep 2
    continue
  end
  email = imap.fetch(email_id,'ENVELOPE').first.attr["ENVELOPE"]
  
  if email.subject != "Wellcome to Ticktensio" ||
     Time.parse(email.date) < (Time.now - 60)
    raise "Organization email was not sent" if time >= 29
    sleep 2
  else
    break
  end
end

puts "success"
