document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector('.custom-form');
  
    if (form) {
      form.addEventListener('submit', function(event) {
        const titleField = form.querySelector('input[name="topic[title]"]');
        const contentField = form.querySelector('input[name="topic[content]"]');
        let valid = true;
  
        // Clear previous errors
        form.querySelectorAll('.error-message').forEach(e => e.remove());
  
        if (!titleField.value.trim()) {
          const error = document.createElement('div');
          error.className = 'error-message';
          error.textContent = 'Veuillez entrer un titre pour votre topic.';
          titleField.parentNode.appendChild(error);
          titleField.classList.add("is-invalid");
          valid = false;
        } else {
          titleField.classList.remove("is-invalid");
        }
  
        if (!contentField.value.trim()) {
          const error = document.createElement('div');
          error.className = 'error-message';
          error.textContent = 'Veuillez entrer un contenu pour votre topic.';
          contentField.parentNode.appendChild(error);
          contentField.classList.add("is-invalid");
          valid = false;
        } else {
          contentField.classList.remove("is-invalid");
        }
  
        if (!valid) {
          event.preventDefault();
        }
      });
    }
  });
  