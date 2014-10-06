//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require artists
//= require releases
//= require_self

$(document).on('ready', function() {
  $(document).foundation();
});
$(document).on('page:before-change', function() {
  $('#loading').fadeIn(250);
});
$(document).on('page:load', function() {
  $('#loading').fadeOut(250);
  $(document).foundation();
});
