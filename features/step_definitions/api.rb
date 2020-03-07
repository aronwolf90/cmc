# frozen_string_literal: true

require "jsonpath"
require "nokogiri"

if defined?(Rack)

  # Monkey patch Rack::MockResponse to work properly with response debugging
  class Rack::MockResponse
    def to_str
      body
    end
  end

  World(Rack::Test::Methods)

end

def set_header(key, value)
  @headers ||= {}
  @headers[key] = value
end

Given(/^I set headers:$/) do |headers|
  headers.rows_hash.each { |k, v| set_header k, v }
end

When(/^I send a (GET|PATCH|POST|PUT|DELETE) request (?:for|to) "([^"]*)"(?: with the following:)?$/) do |*args|
  request_type = args.shift
  path = args.shift
  input = args.shift
  url = "#{Capybara.app_host}/#{path}"

  @response =
    begin
      case request_type
      when "GET"
        RestClient::Request.execute(
          method: :get,
          url: url,
          headers: @headers,
          max_redirects: 0
        )
      when "PATCH"
        RestClient::Request.execute(
          method: :patch,
          url: url,
          payload: StringIO.new(input),
          headers: @headers,
          max_redirects: 0
        )
      when "PUT"
        RestClient::Request.execute(
          method: :put,
          url: url,
          payload: StringIO.new(input),
          headers: @headers,
          max_redirects: 0
        )
      when "POST"
        RestClient::Request.execute(
          method: :post,
          url: url,
          payload: StringIO.new(input),
          headers: @headers,
          max_redirects: 0
        )
      when "DELETE"
        RestClient::Request.execute(
          method: :delete,
          url: url,
          headers: @headers,
          max_redirects: 0
        )
      end
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
end

Then(/^the response status should be "([^"]*)"$/) do |status|
  expect(@response&.code&.to_i).to eq(status.to_i)
end

Then(/^the JSON response should be:$/) do |json|
  expected = JSON.parse(json)
  actual = JSON.parse(@response.body)

  if expected == actual
    expect(Hashdiff.diff(actual, expected)).to be_empty
  else
    expect(actual).to eq(expected)
  end
end

Given(/^(?:|I )send a multipart (POST|PUT) request (?:for|to) "([^"]*)" with:/) do |method, path, body|
  body = body.hashes

  params = body.inject({}) do |hash, row|
    if row["Filename"].present?
      hash[row["Name"]] = File.open(Rails.root.join("features/support/attachments/", row["Filename"]), "r")
    else
      hash[row["Name"]] = row["Content"].strip
    end
    hash
  end


  @response =
    begin
      case method
      when "PUT"
        RestClient.patch("#{Capybara.app_host}/#{path}", params, @headers)
      when "POST"
        RestClient.post("#{Capybara.app_host}/#{path}", params, @headers)
      end
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
end

Then(/^has the following headers:$/) do |headers|
  response_headers = @response.headers.transform_keys do |key|
    key.to_s.split("_").map(&:capitalize).join("-")
  end

  expect(response_headers).to include headers.rows_hash
end
