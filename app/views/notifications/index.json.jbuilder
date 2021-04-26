json.array! @notifications do |notification|
    json.actor notification.actor.username
    json.action notification.action
    json.unread !notification.read_at?
    json.notifiable do 
        json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
    end
    # json.url root_path(notification.notifiable.media, anchor: dom_id(/event))
end