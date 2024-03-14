// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

document.addEventListener("turbolinks:load", function() {
    const textareas = document.querySelectorAll('.auto-resize-textarea');
    textareas.forEach(textarea => {
      autoResize(textarea);
      textarea.addEventListener('input', () => autoResize(textarea));
    });
  
    function autoResize(textarea) {
      textarea.style.height = 'auto';
      textarea.style.height = (textarea.scrollHeight) + 'px';
    }
  });