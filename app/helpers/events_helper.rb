module EventsHelper

  def duration_in_text(event)
    return event.duration.strftime("%I hours %M minutes")
  end

  def dt_in_text(event)
    return event.scheduled_time.strftime("%A, %B %d %Y  Time: %I:%M %p")
  end

  def until_time(event)
    return event.scheduled_time + event.duration.strftime("%I").to_i*3600 + event.duration.strftime("%M").to_i*60
  end

  def event_has_started(event)
    now =  Time.zone.utc_to_local(Time.now)
    scheduled_time =  Time.zone.utc_to_local(event.scheduled_time)
    return now > scheduled_time
  end

  def event_has_ended(event)
    now =  Time.zone.utc_to_local(Time.now)
    until_time =  Time.zone.utc_to_local(until_time(event))
    return now > until_time
  end
end


def dt_to_text(datetime)
  return datetime.strftime("%A, %B %d %Y  Time: %I:%M %p")
end