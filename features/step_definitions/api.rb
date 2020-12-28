# frozen_string_literal: true

require "jsonpath"
require "nokogiri"

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
          payload: input.present? ? StringIO.new(input) : nil,
          headers: @headers,
          max_redirects: 0
        )
      when "POST"
        RestClient::Request.execute(
          method: :post,
          url: url,
          payload: input.present? ? StringIO.new(input) : nil,
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

  if ENV["PRINT_RESPONSE"]
    puts "The response is:"
    puts JSON.pretty_generate(actual)
  end

  expect(Hashdiff.diff(actual, expected)).to eq([])
end

Then(/^the JSON response should match:$/) do |json|
  sort_hash = lambda do |hash|
    hash.sort_by { |key, value| key }.map do |key, value|
      if value.is_a?(Hash)
        [key, sort_hash.(value)]
      else
        [key, value]
      end
    end.to_h
  end

  expected = sort_hash.(JSON.parse(json)).to_s
  actual = sort_hash.(JSON.parse(@response.body)).to_s

  if ENV["PRINT_RESPONSE"]
    puts "The response is:"
    puts JSON.pretty_generate(JSON.parse(@response.body))
  end

  regexes = expected.scan(/<([^>]*)>/).map(&:first)

  literal_parts = expected.split(/<[^>]*>/).map do |part|
    Regexp.quote(part)
  end

  index = -1
  expected_regex = literal_parts.inject do |result, part|
    index += 1
    result + regexes[index] + part
  end

  expect(actual).to match(Regexp.new(expected_regex))
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
