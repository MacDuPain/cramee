document.addEventListener("DOMContentLoaded", function() {
  const form = document.querySelector(".custom-form");

  form.addEventListener("submit", function(event) {
    const contentField = form.querySelector("input[name='comment[content]']");

    if (!contentField.value.trim()) {
      alert("Veuillez entrer un commentaire.");
      contentField.classList.add("is-invalid");
      event.preventDefault();
    } else {
      contentField.classList.remove("is-invalid");
    }
  });
});
