require("flatpickr");

import flatpickr from "flatpickr";

const scheduled_time = document.getElementById("#event_scheduled_time");
if (scheduled_time) {
  flatpickr(scheduled_time, {});
}
