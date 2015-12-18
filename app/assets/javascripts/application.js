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
//= require jquery.cookie
//= require bootstrap-sprockets
//= require jquery_ujs
//= require_tree .

function initialize() {
  $("#accordion1").on("hide.bs.collapse", function(){
    $("#accordion1 .glyphicon").replaceWith('<span class="glyphicon glyphicon-triangle-bottom pull-right"></span>');
  });
  $("#accordion1").on("show.bs.collapse", function(){
    $("#accordion1 .glyphicon").replaceWith('<span class="glyphicon glyphicon-triangle-top pull-right"></span>');
  });

  $("#accordion2").on("hide.bs.collapse", function(){
    $("#accordion2 .glyphicon").replaceWith('<span class="glyphicon glyphicon-triangle-bottom pull-right"></span>');
  });
  $("#accordion2").on("show.bs.collapse", function(){
    $("#accordion2 .glyphicon").replaceWith('<span class="glyphicon glyphicon-triangle-top pull-right"></span>');
  });

  var url = document.location.hash;
  if (url.match('#')) {
    console.log('matched');
    $(".nav-tabs a[href='" + url + "']").tab('show');
  }


  $("input#shipping").on('click', shipFunction);
}

function shipFunction() {
    $("#shipform").toggle();
}

$(document).ready(initialize);
