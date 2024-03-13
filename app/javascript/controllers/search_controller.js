import { Controller } from "@hotwired/stimulus"

// Controller that dynamically fetches search results from the body as
// introduced on an input. Then it fills the `results` elements with them.
export default class extends Controller {
  static targets = ["body"]

  connect() {
    document.getElementById("search_body").focus();
  }

  load(event) {
    event.preventDefault();

    try {
      fetch("/searches/search?" + new URLSearchParams({body: this.bodyTarget.value}))
        .then(response => response.text())
        .then(html => {
          document.getElementById("results").innerHTML = html;
          document.getElementById("save-search").classList.toggle("hidden");
        })
    } catch (error) {
      document.getElementById("results").innerHTML = '<div class="notice">Something went wrong!</div>'
    }
  }

  save(event) {
    event.preventDefault();

    document.getElementById("search-form-submit").classList.toggle("hidden");
    document.getElementById("save-search").classList.toggle("hidden");
    document.getElementById("search-form-name").classList.toggle("hidden");
    document.getElementById("search-form-shared").classList.toggle("hidden");
    document.getElementById("search_name").focus();
  }
}
