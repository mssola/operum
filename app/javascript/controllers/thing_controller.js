import { Controller } from "@hotwired/stimulus"

// Gathers all the methods that are relevant when manipulating things.
export default class extends Controller {
  // Update the external link depending on the changed value. The link will also
  // be hidden/shown depending if the current URL is empty or not.
  updateLink() {
    let cur = document.getElementById("thing_url").value.trim();

    if (cur === "") {
      document.getElementById("thing-external-url-id").classList.add('hidden');
    } else {
      document.getElementById("thing-external-url-id").classList.remove('hidden');
      document.getElementById("thing-external-url-id").href = cur;
    }
  }
}
