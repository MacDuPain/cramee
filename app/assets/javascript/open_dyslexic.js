document.addEventListener('DOMContentLoaded', function() {
    const toggleLink = document.getElementById('toggleFont');
  
    const isDyslexiaFontEnabled = localStorage.getItem('dyslexiaFontEnabled') === 'true';
    if (isDyslexiaFontEnabled) {
        toggleDyslexiaFont(true);
    }
  
    if (toggleLink) {
        toggleLink.addEventListener('click', function(event) {
            event.preventDefault(); // Empêche le comportement par défaut du lien
            const isEnabled = document.body.classList.contains('dyslexia-font');
            toggleDyslexiaFont(!isEnabled);
        });
    } else {
        console.error('Toggle link not found');
    }

    function toggleDyslexiaFont(enable) {
        const elementsToToggle = document.querySelectorAll('body, h1, h2, h3, h4, h5, h6, p, span, div');
  
        elementsToToggle.forEach(function(element) {
            if (enable) {
                element.classList.add('dyslexia-font');
            } else {
                element.classList.remove('dyslexia-font');
            }
        });
  
        if (enable) {
            toggleLink.title = 'Police pour dyslexie Désactivée';
            localStorage.setItem('dyslexiaFontEnabled', 'true');
        } else {
            toggleLink.title = 'Police pour dyslexie Activée';
            localStorage.setItem('dyslexiaFontEnabled', 'false');
        }
    }
});
