# frozen_string_literal: true

Given(/^an user exists with an id of 1$/) do
  Admin.create!(id: 1, email: "test@localhost.de", password: "testtest", password_confirmation: "testtest")
end

Given(/^a test-organization exists and is loaded$/) do
  allow(Settings).to receive(:multi_tenant).and_return(true)
  RestClient.post(
    "#{Capybara.app_host}/api/v1/test_organizations",
    { data: { attributes: {} } }.to_json, content_type: :json, accept: :json
  )
  allow(Capybara).to receive(:app_host).and_return "http://test-organization.#{Settings.test_host}:#{Settings.test_port}"
end

Given(/^I am an user with an id of 1$/) do
  Admin.create!(id: 1, email: "test@localhost.de", password: "testtest", password_confirmation: "testtest")
end

Given(/^I with an id of 1 have an current record$/) do
  Record.create!(id: 1, user_id: 1, start_time: "2018-02-04T12:00:00.000Z")
end

Given(/a contact exists with an id of 1/) do
  contact_avatar = ContactAvatar.create!(
    id: 1,
    file: File.open(Rails.root.join("features", "support", "attachments", "avatar.jpg"))
  )
  FactoryBot.create(
    :contact,
    id: 1,
    contact_avatar: contact_avatar,
    name: "Frantz",
    description: "Test description",
    telephone: "01727873609",
    mobile: "01702876609",
    fax: "01727876620",
    address_city: "Augsburg",
    address_zip: "86153",
    address_country: "germany",
    address_street: "Street",
    address_number: "8"
  )
end

Given(/^a contact avatar exists with an id of 1/) do
  ContactAvatar.create!(
    id: 1,
    file: File.open(Rails.root.join("features", "support", "attachments", "avatar.jpg"))
  )
end

Given(/^a (document|document_file) exists with an id of 1/) do |*_args|
  document_file = DocumentFile.create!(
    id: 1,
    file: "avatar.jpg"
  )
  file = Rails.root.join("features", "support", "attachments", "avatar.jpg")
  ChunckUploader.new(document_file).upload(file)
  FactoryBot.create(:document, document_file: document_file, name: "test")
end

Then(/^a document_file with an id of 1 and chunck0.txt/) do
  FactoryBot.create(
    :document_file,
    id: 1,
    file: File.open(Rails.root.join("features", "support", "attachments", "avatar.jpg"))
  )
end
