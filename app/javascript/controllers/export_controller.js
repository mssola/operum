import { Controller } from "@hotwired/stimulus"

// Controller used in the exports#new page. That is, it allows us to change the
// format to be picked up by the exporter.
export default class extends Controller {
  static targets = ["id"]

  connect() {
    const url = `/searches/${this.idTarget.value}/exports.csv`;
    document.getElementById("export-format-button").setAttribute('href', url);
  }

  // Change the format to be used.
  change() {
    const format = document.getElementById("export-select-format").value;
    const url = `/searches/${this.idTarget.value}/exports.${format}`;
    document.getElementById("export-format-button").setAttribute('href', url);
  }
}
