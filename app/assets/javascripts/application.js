// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

var resize_thumbs = function(){
  var thumb = document.getElementsByClassName('thumbnail')[0];
  var width = thumb.clientWidth;
  $('.img-container').css({ "height": width+"px" });
};

$(document).ready(resize_thumbs);
$(window).resize(resize_thumbs);
$(document).on('page:change', resize_thumbs);

/**
 * Listen to scroll to change header opacity class
 */
function checkScroll(){
    var startY = $('.navbar').height(); //The point where the navbar changes in px
    if($(window).scrollTop() > startY || $(window).width() < 768){
      $('.navbar').addClass("scrolled");
    }
    else{
      $('.navbar').removeClass("scrolled");
    }
}

$(window).on("scroll load resize", function(){
  checkScroll();
  });
