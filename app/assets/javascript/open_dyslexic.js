document.addEventListener('DOMContentLoaded', function() {
    const toggleLink = document.getElementById('toggleFont');
  
    if (toggleLink) {
        toggleLink.addEventListener('click', function(event) {
            event.preventDefault(); // Empêche le comportement par défaut du lien
  
            // Liste des éléments à cibler
            const elementsToToggle = document.querySelectorAll('body, h1, h2, h3, h4, h5, h6, p, span, div');
  
            elementsToToggle.forEach(function(element) {
                element.classList.toggle('dyslexia-font');
            });
  
            if (document.body.classList.contains('dyslexia-font')) {
                toggleLink.title = 'Police pour dyslexie Désactivée';
            } else {
                toggleLink.title = 'Police pour dyslexie Activée';
            }
        });
    } else {
        console.error('Toggle link not found');
    }
  });
  