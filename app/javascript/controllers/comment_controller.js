import { Controller } from "@hotwired/stimulus"

// Controller that handles actions for adding some dynamism like showing/hiding
// comments.
export default class extends Controller {
  // Cancel the current operation for comments.
  toggle(event) {
    event.preventDefault();

    const parent    = event.target.closest('.comment');
    const regl_body = parent.getElementsByClassName('comment-body');
    const edit_body = parent.getElementsByClassName('comment-edit-body');
    if (regl_body.length !== 1 || edit_body.length !== 1) {
      return;
    }

    regl_body[0].classList.toggle('hidden');
    edit_body[0].classList.toggle('hidden');
  }

  // Hide/show the "New comment" button & form properly, while also focusing on
  // the text area when shown.
  toggleNewComment(event) {
    event.preventDefault();

    document.getElementById("comment-new-button").classList.toggle('hidden');

    let body = document.getElementById("comment-new-body");
    body.classList.toggle('hidden');

    // BUG (minor): this is not working! (bug in Trix?)
    if (!body.classList.contains("hidden")) {
      document.getElementById("comment_content").focus();
    }
  }
}
