require 'httparty'
require 'json'
require 'hash_symbolizer'
require 'ostruct'
require 'gimizen/version'

module Gimizen
  class << self
    attr_accessor :api_url, :api_key
    def configure(&blk); class_eval(&blk); end
  end

  def self.create_ticket(hash, full_response=false)
    # Format the subject and comment
    subject = format_subject(hash[:subject])
    comment = format_comment(hash[:comment])
    # Format json data
    json_data = format_json_data(hash)
    # Perform request
    return post_to_zendesk("#{@domain}/tickets.json", json_data, full_response)
  end

  def self.format_subject(subject = nil)
    raise Exception.new('No subject provided') if subject.nil? || subject.empty?
    subject
  end

  def self.format_comment(comment = nil)
    raise Exception.new('No comment provided') if comment.nil? || comment.empty?
    comment
  end

  def self.format_json_data(hash)
    json_data = {
      ticket: {
        subject: hash[:subject],
        comment: {
          body: hash[:comment]
        }
      }
    }.to_json
  end

  def self.post_to_zendesk(url, data, full_response=false)
    # Post method to Zendesk
    response = HTTParty.post(
      url, 
      body: data,
      basic_auth: {username: "#{@email_address}/token", password: @api_token},
      headers: {'Content-Type' => 'application/json'}
    )
    # Return full response or succes message
    full_response ? handle_response(response.body) : succes_message(response.code)
  end

  def self.handle_response(response)
    # Format Zendesk response
    response = JSON.parse(response).symbolize_keys(true)
    response = OpenStruct.new response[:ticket]
    response
  end

  def self.succes_message(response_code)
    # Format status message
    status_message = {
      created: true
    }
    # Change hash if tickets was nit created
    status_message[:created] = false if response_code != 201
    # Return status message
    OpenStruct.new status_message
  end

  def self.version_string
    "Gimizen version #{Gimizen::VERSION}"
  end
end

# Set default configuration
Gimizen.configure do
  @domain        = 'https://gimiscale.zendesk.com/api/v2'
  @email_address = 'zendesk@gimiscale.com'
  @api_token     = '123456789AbCdEfGhIjKlMnOpQrStUvWxYz'
end
