[![Build Status](https://travis-ci.org/GiMiScale/gimizen.png?branch=master)](https://travis-ci.org/GiMiScale/gimizen) [![Code Climate](https://codeclimate.com/github/GiMiScale/gimizen.png)](https://codeclimate.com/github/GiMiScale/gimizen) [![Gem Version](https://badge.fury.io/rb/gimizen.png)](http://badge.fury.io/rb/gimizen)

# Gimizen

Simple API wrapper for Zendesk. Creating tickets for Zendesk should be as simple as 'zen'.

## Installation

Add this line to your application's Gemfile:

    gem 'gimizen'

And then execute:

    $ bundle

Or install it yourself:

    $ gem install gimizen

## Setup

Add file `config/initializers/gimizen.rb`.

    require 'gimizen'
    Gimizen.configure do |config|
      config.domain        = 'https://gimiscale.zendesk.com/api/v2'
      config.email_address = 'zendesk@gimiscale.com'
      config.api_token     = '123456789AbCdEfGhIjKlMnOpQrStUvWxYz'
    end

## Example usage

Simple Zendesk ticket creation:

    response = Gimizen.create_ticket({subject: 'Gimizen', comment: 'This is a test ticket'})
    # => #<OpenStruct created=true>
    response.created
    # => true

Create a Zendesk ticket with response body:

    response = Gimizen.create_ticket({subject: 'Gimizen', comment: 'This is a test ticket'}, true)
    # => #<OpenStruct url="https://gimiscale.zendesk.com/api/v2/tickets/942.json", id=942, external_id=nil, via={:channel=>"api", :source=>{:from=>{}, :to=>{}, :rel=>nil}}, created_at="2013-09-25T13:13:54Z", updated_at="2013-09-25T13:13:54Z", type=nil, subject="Gimizen", description="This is a test ticket", priority=nil, status="new", recipient=nil, requester_id=275909116, submitter_id=275909116, assignee_id=nil, organization_id=nil, group_id=20329092, collaborator_ids=[], forum_topic_id=nil, problem_id=nil, has_incidents=false, due_at=nil, tags=["gimiscale"], custom_fields=[], satisfaction_rating=nil, sharing_agreement_ids=[], fields=[]>
    response.id
    # => 942
    response.subject
    # => "Gimizen"
    response.description
    # => "This is a test ticket"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
