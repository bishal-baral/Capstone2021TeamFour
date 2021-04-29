# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event = Event.new(user_id: 216, scheduled_time: Time.now + 60 * 60 * 24 * 5,
                       title: 'Test Event')
  end

  test 'should be valid' do
    assert @event.valid?
  end

  test 'there should be an event title' do
    @event.title = nil
    assert_not @event.valid?
  end

  test 'length of title should be limited' do
    @event.title = 'title' * 20
    assert_not @event.valid?
  end

  test 'there should be an associated user with event' do
    @event.user_id = nil
    assert_not @event.valid?
    @event.user_id = 3
    assert_not @event.valid?
  end

  test 'there should be a time scheduled for the event' do
    @event.scheduled_time = nil
    assert_not @event.valid?
  end
end
