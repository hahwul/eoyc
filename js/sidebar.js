(function () {
  var sidebar = document.getElementById('sidebar');

  window.toggleSidebar = function () {
    if (sidebar) sidebar.classList.toggle('open');
  };

  // Highlight active sidebar link
  var path = window.location.pathname.replace(/\/$/, '');
  var links = document.querySelectorAll('.bp-sidebar-link');
  for (var i = 0; i < links.length; i++) {
    var href = links[i].getAttribute('href');
    if (href) {
      var linkPath = href.replace(/\/$/, '');
      if (linkPath === path) {
        links[i].classList.add('active');
      }
    }
  }

  // Close sidebar on outside click (mobile)
  document.addEventListener('click', function (e) {
    if (sidebar && sidebar.classList.contains('open')) {
      if (!sidebar.contains(e.target) && !e.target.closest('.bp-sidebar-toggle')) {
        sidebar.classList.remove('open');
      }
    }
  });
})();
