(function() {
  var Notifications,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Notifications = (function() {
    function Notifications() {
      this.handleSuccess = __bind(this.handleSuccess, this);
      this.handleClick = __bind(this.handleClick, this);
      this.notifications = $("[data-behavior='notifications']");
      if (this.notifications.length > 0) {
        this.handleSuccess(this.notifications.data("notifications"));
        $("[data-behavior='notifications-link']").on("click", this.handleClick);
        setInterval(((function(_this) {
          return function() {
            return _this.getNewNotifications();
          };
        })(this)), 5000);
      }
    }

    Notifications.prototype.getNewNotifications = function() {
      return $.ajax({
        url: "/notifications.json",
        dataType: "JSON",
        method: "GET",
        success: this.handleSuccess
      });
    };

    Notifications.prototype.handleClick = function(e) {
      return $.ajax({
        url: "/notifications/mark_as_read",
        method: "POST",
        dataType: "JSON",
        success: function() {
          return $("[data-behavior='unread-count']").text(0);
        }
      });
    };

    Notifications.prototype.handleSuccess = function(data) {
      var items, unread_count;
      items = $.map(data, function(notification) {
        return "<a class='dropdown-item' href='#'> " + notification.actor + " " + notification.action + " " + notification.notifiable.type + " </a>";
      });
      unread_count = 0;
      $.each(data, function(i, notification) {
        if (notification.unread) {
          return unread_count += 1;
        }
      });
      $("[data-behavior='unread-count']").text(unread_count);
      return $("[data-behavior='notification-items']").html(items);
    };

    $(document).ready(function() {
      $('.dropdown-toggle').dropdown();
    });

    return Notifications;

  })();

  jQuery(function() {
    return new Notifications;
  });

}).call(this);