# frozen_string_literal: true

class GoogleCalenderClient
  attr_reader :organization, :google_authorization_data, :code

  def initialize(organization: nil, google_authorization_data: nil, code: nil)
    @organization = organization
    @google_authorization_data = google_authorization_data
    @code = code
  end

  def self.authentication_url(**args)
    new(**args).authentication_url
  end

  def self.get_access_token(code:, **args)
    client = new(**args).client
    client.code = code
    response = client.fetch_access_token!
    GoogleAuthorizationData.new(
      access_token: response["access_token"],
      expires_at: (Time.zone.now + response["expires_in"].seconds).to_datetime,
      refresh_token: response["refresh_token"]
    )
  end

  def self.create_calender(name:, **args)
    calender_service = new(**args).calender_service

    calender = Google::Apis::CalendarV3::Calendar.new(
      summary: name
    )

    calender_service.insert_calendar(calender)
  end

  def self.get_event(google_calender_id, google_calender_event_id, **args)
    calender_service = new(**args).calender_service

    calender_service.get_event(google_calender_id, google_calender_event_id)
  end

  def self.create_event(google_calender_id:, title:, description:, start_time:, end_time:, **args)
    calender_service = new(**args).calender_service

    event = Google::Apis::CalendarV3::Event.new(
      summary: title,
      description: description,
      start: start_time,
      end: end_time
    )

    calender_service.insert_event(google_calender_id, event)
  end

  def self.update_event(google_calender_id:, google_calender_event_id:, title:, description:, start_time:, end_time:, **args)
    calender_service = new(**args).calender_service

    event = Google::Apis::CalendarV3::Event.new(
      summary: title,
      description: description,
      start: start_time,
      end: end_time
    )

    calender_service.update_event(google_calender_id, google_calender_event_id, event)
  end

  def self.authorize!(**args)
    google_authorization_data = args[:google_authorization_data]

    if google_authorization_data.expires_at.present? &&
       google_authorization_data.expires_at > Time.zone.now + 1.minute
      return google_authorization_data
    end

    client = new(**args).client
    client.update!(google_authorization_data.to_h)
    response = client.refresh!
    GoogleAuthorizationData.new(
      access_token: response["access_token"],
      expires_at: response["expires_at"],
      refresh_token: google_authorization_data.refresh_token
    )
  end

  def self.watch(google_calender_id:, **args)
    calender_service = new(**args).calender_service
    address = ApplicationHelper.organization_url + "/google_calenders/notification"
    address = address.tr("http://", "https://")

    calender_service.watch_event(
      google_calender_id,
      Google::Apis::CalendarV3::Channel.new(
        address: address,
        type: "web_hook"
      )
    )
  end

  def authentication_url
    client.authorization_uri.to_s
  end

  def client
    @client ||= Signet::OAuth2::Client.new(client_options.merge(google_authorization_data.to_h))
  end

  def calender_service
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    service
  end

  private
    def authorize_client!
      client.update!(google_authorization_data.to_h)
      client.refresh! if google_authorization_data.expires_at < Time.zone.now
    end

    def client_options
      {
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        redirect_uri: "http://#{Settings.host}/google_calenders/create_callback",
        state: organization&.name
      }.merge(Settings.google_calender).compact
    end
end
