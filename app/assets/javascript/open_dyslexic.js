document.addEventListener('DOMContentLoaded', function() {
  const toggleButton = document.getElementById('toggleFont');

  if (toggleButton) {
      toggleButton.addEventListener('click', function() {
          // Liste des éléments à cibler
          const elementsToToggle = document.querySelectorAll('body, h1, h2, h3, h4, h5, h6, p, span, div');

          elementsToToggle.forEach(function(element) {
              element.classList.toggle('dyslexia-font');
          });

          if (document.body.classList.contains('dyslexia-font')) {
              toggleButton.textContent = 'Police pour dyslexie Désactivée';
          } else {
              toggleButton.textContent = 'Police pour dyslexie Activée';
          }
      });
  } else {
      console.error('Toggle button not found');
  }
});