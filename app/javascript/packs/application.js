// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// import the bootsrap library.
import "bootstrap"

// Import WOW
window.WOW = require('wowjs').WOW;
new WOW().init();

// import the app/assets/stylesheets/application.css
// file from the previous step.
import "../../assets/stylesheets/application"

window.setTimeout(function() {
$(".alert").fadeTo(500, 0).slideUp(500, function(){
    $(this).remove();
});
}, 3000);

$(window).scroll(function () {
if ($(window).scrollTop() >= 50) {
$('.navbar').fadeTo(0, 500).css('background','black');
} else {
$('.navbar').fadeTo(0, 500).css('background','transparent');
}
});
// function hideNotice() {
//   setInterval(function() {
//     document.querySelector('.notification').style.display = "none";
//   }, 3000);
// }
// hideNotice();
