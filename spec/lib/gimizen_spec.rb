require 'spec_helper'

describe Gimizen do
  it 'raises an exception for empty subjects' do
    expect { Gimizen.format_subject(nil) }.to raise_error
    expect { Gimizen.format_subject('') }.to raise_error
  end

  it 'raises an exception for empty comments' do
    expect { Gimizen.format_comment(nil) }.to raise_error
    expect { Gimizen.format_comment('') }.to raise_error
  end

  it 'format the json data' do
    json = Gimizen.format_json_data({subject: 'Gimizen', comment: 'This is a test ticket'})
    json = JSON.parse(json)
    json.should_not                          eq nil
    json['ticket'].should_not                eq nil
    json['ticket'].should                    have_key('subject')
    json['ticket'].should                    have_key('comment')
    json['ticket']['comment'].should         have_key('body')
    json['ticket']['subject'].should         eq 'Gimizen'
    json['ticket']['comment']['body'].should eq 'This is a test ticket'
  end

  it 'creates a zendesk ticket' do
    VCR.use_cassette('create_ticket') do
      response = Gimizen.create_ticket({subject: 'Gimizen', comment: 'This is a test ticket'})
      puts response
      response.should_not         eq nil
      response.created.should_not eq nil
      response.created.should     eq true
    end
  end

  it 'creates a zendesk ticket with full response body' do
    VCR.use_cassette('create_ticket') do
      response = Gimizen.create_ticket({subject: 'Gimizen', comment: 'This is a test ticket'}, true)
      response.id.should_not      eq nil
      response.subject.should     eq 'Gimizen'
      response.description.should eq 'This is a test ticket'
    end
  end

  it 'should return correct version string' do
    Gimizen.version_string.should eq "Gimizen version #{Gimizen::VERSION}"
  end
end