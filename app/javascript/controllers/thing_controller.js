import { Controller } from "@hotwired/stimulus"

// Gathers all the methods that are relevant when manipulating things.
export default class extends Controller {
  static targets = ["identifier"];

  connect() {
    // The "target" completion is achieved by managing updates from authors
    // (first part) and year (last one). We have to account when connecting that
    // we might come from a reload of the page, which would contain partial
    // data. Hence, this ought to be initialized with the current values from
    // their respective inputs.
    this.firstPart = document.getElementById("thing_authors").value.trim();
    this.lastPart = document.getElementById("thing_year").value.trim();

    // Whether autocompletion has been canceled or not. This will be forced to
    // true when `#cancel` is called (i.e. the user has manually entered a value
    // for "target"), or if we are coming from a page that already had data
    // filled in.
    this.canceled = this.firstPart !== '' && this.lastPart !== '' &&
      document.getElementById("thing_target").value.trim() !== '';
  }

  // Update the information we get from the authors field so to autocomplete it
  // into the "target" field if possible.
  authorsUpdate() {
    if (this.canceled) {
      return;
    }

    const text = document.getElementById("thing_authors").value.trim();
    if (text === '') {
      return;
    }

    this.firstPart = text.split(',').map(this.parseAuthor).join('');
    this.identifierTarget.value = `${this.firstPart}${this.lastPart}`;
  }

  // Returns the author compressed as expected for "target" autocompletion.
  parseAuthor(author) {
    // First of all try to match a pair of "_". If these are found, then we have
    // to return whatever is in there with no spaces.
    let idx = author.indexOf('_');

    if (idx > -1) {
      let idx2 = author.indexOf('_', idx + 1);
      if (idx2 > -1) {
        return author.substring(idx + 1, idx2).replace(' ', '');
      }
    }

    // There was no pair of underscores, let's proceed by picking on the last
    // name.
    return author
      .split(' ').pop().trim()  // Pick the last element.
      .replace('-', '');        // "Last-Other" => "LastOther"
  }

  // Update the information we get from the year field so to autocomplete it
  // into the "target" field if possible.
  yearUpdate() {
    if (this.canceled) {
      return;
    }

    const text = document.getElementById("thing_year").value.trim();
    if (text === '') {
      return;
    }

    this.lastPart = text;
    this.identifierTarget.value = `${this.firstPart}${this.lastPart}`;
  }

  // The user is writing into the "target" field directly: cancel autocompletion
  // altogether.
  cancel() {
    this.canceled = true;
  }

  // Update the external link depending on the changed value. The link will also
  // be hidden/shown depending if the current URL is empty or not.
  updateLink() {
    let cur = document.getElementById("thing_url").value.trim();

    if (cur === "") {
      document.getElementById("thing-external-url-id").classList.add('hidden');
      document.getElementById("thing-access-div").classList.add('hidden');
    } else {
      document.getElementById("thing-external-url-id").classList.remove('hidden');
      document.getElementById("thing-access-div").classList.remove('hidden');
      document.getElementById("thing-external-url-id").href = cur;
    }
  }
}
