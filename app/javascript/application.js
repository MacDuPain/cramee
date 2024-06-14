// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require turbolinks
//= require_tree .

import 'bootstrap'
import * as bootstrap from "bootstrap"

document.addEventListener('turbolinks:load', function() {
    // Réinitialiser Bootstrap dropdowns
    var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'))
    var dropdownList = dropdownElementList.map(function (dropdownToggleEl) {
        return new bootstrap.Dropdown(dropdownToggleEl)
    });
});

document.addEventListener('turbolinks:load', function() {
    setTimeout(function() {
      var alerts = document.querySelectorAll('.alert');
      alerts.forEach(function(alert) {
        alert.style.transition = 'opacity 0.5s ease';
        alert.style.opacity = '0';
        setTimeout(function() {
          alert.remove();
        }, 500); // Correspond à la durée de la transition
      });
    }, 4000); // 4 seconds
  });
  