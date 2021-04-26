class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")

    if @notifications.length > 0
      @handleSuccess @notifications.data("notifications")
      $("[data-behavior='notifications-link']").on "click", @handleClick

      setInterval (=>
        @getNewNotifications()
      ), 5000

  getNewNotifications: ->
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleClick: (e) =>
    $.ajax(
      url: "/notifications/mark_as_read"
      method: "POST"
      dataType: "JSON"
      success: ->
        $("[data-behavior='unread-count']").text(0)
    )

    

  handleSuccess: (data) =>
    items = $.map data, (notification) ->
        "<a class='dropdown-item' href='#'> #{notification.actor} #{notification.action} #{notification.notifiable.type} </a>"
     

    unread_count = 0
    $.each data, (i, notification) ->
      if notification.unread
        unread_count += 1

    $("[data-behavior='unread-count']").text(unread_count)
    $("[data-behavior='notification-items']").html(items)
  
  $(document).ready ->
    $('.dropdown-toggle').dropdown()
    return



jQuery ->
  new Notifications