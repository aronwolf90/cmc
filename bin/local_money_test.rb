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

def monkey_test(host)
  %w[administration administration/board_lists administration/projects administration/projects/1 administration/wiki administration/users/1 administration/contacts/1 administration/archive].each do |page|
    visit("#{host}/#{page}")
    page.evaluate_script(%[
        (function() {
            function callback() {
                gremlins.createHorde({
                    species: [gremlins.species.clicker()],
                    mogwais: [gremlins.mogwais.alert(),gremlins.mogwais.fps(),gremlins.mogwais.gizmo()],
                    strategies: [gremlins.strategies.distribution()]
                }).unleash();
            }
            var s = document.createElement("script");
            s.src = "https://unpkg.com/gremlins.js";
            if (s.addEventListener) {
                s.addEventListener("load", callback, false);
            } else if (s.readyState) {
                s.onreadystatechange = callback;
            }
            document.body.appendChild(s);
        })()
    ])
    sleep 10
  end
end

visit "http://test-organization.lvh.me:3000"
fill_in "Email", with: "admin@lvh.me"
fill_in "Password", with: "testtest"
click_button "Login"
monkey_test("http://test-organization.lvh.me:3000/")
STDERR.puts page.driver.browser.manage.logs.get(:browser)
