require("bootstrap");

$("#modal-window").find(".modal-content").html("<%= j (render 'new') %>");
$("#modal-window").modal();

$("#modal-window-1").find(".modal-content").html("<%= j (render 'new') %>");
$("#modal-window-1").modal();
