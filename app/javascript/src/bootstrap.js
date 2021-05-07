// inside app/frontend/js/bootstrap_js_files.js
import * as bootstrap from "bootstrap"
import 'bootstrap/js/src/alert'
// import 'bootstrap/js/src/button'
// import 'bootstrap/js/src/carousel'
// import 'bootstrap/js/src/collapse'
// import 'bootstrap/js/src/dropdown'
// import 'bootstrap/js/src/modal'
// import 'bootstrap/js/src/popover'
// import 'bootstrap/js/src/tab'
// import 'bootstrap/js/src/toast'
// import 'bootstrap/js/src/tooltip'

document.addEventListener("DOMContentLoaded", function () {
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })
});
