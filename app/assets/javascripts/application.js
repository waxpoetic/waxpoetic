//= require loader
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .
//= require_self .

// Load foundation before loading all other modules
module.on('before:init', function() {
  $(document).foundation();
});

// Send current scope to modules on load
module.on('init', function(current, event) {
  current($(event.currentTarget));
});

// Load all modules when Turbolinks changes pages as well as immediately
// on DOM ready.
$(document).on('ready page:load', module.init);
