import { Controller } from "@hotwired/stimulus"

// Controller being used by the top application header. It allows the user to
// show/hide the hidden menu with the different options.
export default class extends Controller {
  // Hide/show the hidden navigation menu from the header.
  toggle(event) {
    event.preventDefault();

    // Toggle the up/down arrow.
    const el = document.getElementById("header-chevron");
    if (el.classList[0] === "gg-chevron-down") {
      el.classList.replace("gg-chevron-down", "gg-chevron-up")
    } else {
      el.classList.replace("gg-chevron-up", "gg-chevron-down")
    }

    // Hide/show the hidden navigation menu.
    document.getElementById("hidden-nav").classList.toggle('hidden');
  }
}
