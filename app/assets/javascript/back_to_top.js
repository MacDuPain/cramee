document.addEventListener("DOMContentLoaded", function () {
    var backToTopButton = document.getElementById("backToTop");
  
    window.addEventListener("scroll", function () {
      if (window.scrollY > 200) {
        backToTopButton.style.display = "block";
      } else {
        backToTopButton.style.display = "none";
      }
    });
  
    backToTopButton.addEventListener("click", function (e) {
      e.preventDefault();
      window.scrollTo({
        top: 0,
        behavior: "smooth"
      });
    });
});
  