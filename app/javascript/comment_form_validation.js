// app/assets/javascripts/comment_form_validation.js
document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById("comment-form");
  
    form.addEventListener("submit", function(event) {
      const contentField = document.getElementById("comment-content");
      
      if (!contentField.value.trim()) {
        alert("Le commentaire ne peut pas être vide.");
        contentField.classList.add("is-invalid");
        event.preventDefault();
      } else {
        contentField.classList.remove("is-invalid");
      }
    });
  });
  